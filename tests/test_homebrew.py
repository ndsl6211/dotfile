import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "homebrew.sh"
BASH = shutil.which("bash")


class ArgumentsTest(unittest.TestCase):
    def run_script(self, *arguments, env=None):
        return subprocess.run(
            [BASH, str(SCRIPT), *arguments],
            capture_output=True,
            text=True,
            env=env,
            timeout=30,
        )

    def test_help(self):
        for arguments in [("-h",), ("--help",), ("snapshot", "--help")]:
            with self.subTest(arguments=arguments):
                result = self.run_script(*arguments)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertIn("Usage:", result.stdout)
                self.assertIn("--settings", result.stdout)
                self.assertEqual(result.stderr, "")

    def test_invalid_arguments(self):
        cases = [
            ((), "Expected snapshot or install"),
            (("cleanup", "-s", "personal"), "Unknown command"),
            (("snapshot",), "Settings are required"),
            (("snapshot", "-s"), "requires work or personal"),
            (("snapshot", "-s", "--help"), "requires work or personal"),
            (("snapshot", "-s", "other"), "Unknown settings"),
            (("snapshot", "-s", "../work"), "Unknown settings"),
            (("snapshot", "-p", "personal"), "Unknown option"),
            (("snapshot", "-s", "personal", "extra"), "Unknown option"),
            (
                ("snapshot", "-s", "personal", "--settings", "work"),
                "Settings specified more than once",
            ),
        ]
        for arguments, message in cases:
            with self.subTest(arguments=arguments):
                result = self.run_script(*arguments)
                self.assertNotEqual(result.returncode, 0)
                self.assertIn(message, result.stderr)
                self.assertEqual(result.stdout, "")

    def test_missing_homebrew(self):
        with tempfile.TemporaryDirectory(prefix="brew-path-") as directory:
            result = self.run_script(
                "snapshot", "-s", "personal", env={**os.environ, "PATH": directory}
            )
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Homebrew is required", result.stderr)


class BundleFixture:
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="brew-profiles-")
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name) / "dotfiles with spaces"
        (self.root / "scripts").mkdir(parents=True)
        (self.root / "homebrew").mkdir()
        self.script = self.root / "scripts" / "homebrew.sh"
        shutil.copy2(SCRIPT, self.script)
        self.env = {**os.environ, "HOMEBREW_NO_AUTO_UPDATE": "1"}

    def run_script(self, *arguments):
        return subprocess.run(
            [BASH, str(self.script), *arguments],
            cwd=self.temporary.name,
            env=self.env,
            capture_output=True,
            text=True,
            timeout=180,
        )


class BundleIntegrationTest(BundleFixture, unittest.TestCase):
    def test_missing_install_file(self):
        result = self.run_script("install", "-s", "work")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Brewfile not found", result.stderr)

    def test_homebrew_failure_propagates(self):
        (self.root / "homebrew" / "Brewfile-work").write_text(
            'raise "invalid profile fixture"\n'
        )
        result = self.run_script("install", "--settings", "work")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("invalid profile fixture", result.stdout + result.stderr)

    def test_install_each_profile_with_real_homebrew(self):
        for profile, option in [("work", "-s"), ("personal", "--settings")]:
            with self.subTest(profile=profile):
                brewfile = self.root / "homebrew" / f"Brewfile-{profile}"
                brewfile.write_text("")
                result = self.run_script("install", option, profile)
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
                self.assertIn("0 Brewfile dependencies", result.stdout)
                self.assertEqual(result.stderr, "")
                self.assertEqual(brewfile.read_text(), "")


class SnapshotEndToEndTest(BundleFixture, unittest.TestCase):
    def test_snapshot_replaces_only_selected_profile(self):
        work = self.root / "homebrew" / "Brewfile-work"
        personal = self.root / "homebrew" / "Brewfile-personal"
        work.write_text("# Work profile sentinel\n")
        personal.write_text("# Personal profile sentinel\n")

        result = self.run_script("snapshot", "-s", "personal")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(result.stderr, "")
        self.assertEqual(work.read_text(), "# Work profile sentinel\n")
        snapshot = personal.read_text()
        self.assertNotIn("Personal profile sentinel", snapshot)
        self.assertIn('brew "', snapshot)

        installed = subprocess.run(
            ["brew", "list", "--formula", "--full-name"],
            env=self.env,
            capture_output=True,
            text=True,
            check=True,
            timeout=60,
        )
        recorded = {
            line.split('"')[1]
            for line in snapshot.splitlines()
            if line.startswith('brew "')
        }
        self.assertTrue(recorded)
        self.assertTrue(recorded.issubset(set(installed.stdout.splitlines())))

        code = shutil.which("code")
        if code:
            extensions = subprocess.run(
                [code, "--list-extensions"],
                env=self.env,
                capture_output=True,
                text=True,
                check=True,
                timeout=60,
            )
            for extension in extensions.stdout.splitlines():
                self.assertIn(f'vscode "{extension.lower()}"', snapshot.lower())

        result = self.run_script("snapshot", "--settings", "work")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(result.stderr, "")
        self.assertEqual(personal.read_text(), snapshot)
        self.assertIn('brew "', work.read_text())


class ProfilesTest(unittest.TestCase):
    def test_profile_files(self):
        self.assertFalse((ROOT / "homebrew" / "Brewfile").exists())
        for profile in ("work", "personal"):
            with self.subTest(profile=profile):
                content = (ROOT / "homebrew" / f"Brewfile-{profile}").read_text()
                self.assertIn('brew "', content)


class BootstrapTest(unittest.TestCase):
    def test_installed_homebrew_exits_without_package_installation(self):
        result = subprocess.run(
            [BASH, str(ROOT / "scripts" / "install_homebrew.sh")],
            cwd="/",
            capture_output=True,
            text=True,
            timeout=30,
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("already installed", result.stdout)
        self.assertNotIn("Brewfile", result.stdout)
        self.assertEqual(result.stderr, "")


if __name__ == "__main__":
    unittest.main()
