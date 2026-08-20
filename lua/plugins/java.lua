return {
  -- Mason's google-java-format is the fallback for projects that don't pin a
  -- version themselves. Kept installed on purpose.
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "google-java-format" })
    end,
  },

  -- Format Java with the google-java-format version the project PINS, not
  -- Mason's latest.
  --
  -- Mason installs 1.34.1; cashfree repos pin 1.15.0 via spotless-maven-plugin.
  -- gjf changed how it wraps `case X ->` arrow bodies after 1.15, so saving with
  -- Mason's binary rewrites lines that `mvn spotless:apply` then puts back --
  -- endless formatting churn in diffs.
  --
  -- ~/.local/bin/gjf-spotless reads <googleJavaFormat><version> out of the
  -- nearest pom.xml and runs that exact jar from ~/.m2 (on a JDK 17, since gjf
  -- <=1.16 touches javac internals that moved in 21). It falls back to Mason's
  -- binary when a project pins nothing.
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.java = { "gjf-spotless" }

      opts.formatters = opts.formatters or {}
      opts.formatters["gjf-spotless"] = {
        command = vim.fn.expand("~/.local/bin/gjf-spotless"),
        stdin = true,
        -- Run from the maven root so the script finds the right pom.xml.
        cwd = require("conform.util").root_file({ "pom.xml" }),
        require_cwd = false,
      }
    end,
  },
}
