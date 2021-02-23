local Pipeline(rubyVer, db, license, redmine, dependents) = {
  kind: "pipeline",
  name: rubyVer + "-" + db + "-" + redmine + "-" + license + "-" + dependents,
  steps: [
    {
      name: "tests",
      image: "redmineup/redmineup_ci",
      commands: [
        "service postgresql start && service mysql start && sleep 5",
        "export PATH=~/.rbenv/shims:$PATH",
        "export CODEPATH=`pwd`",
        "/root/run_for.sh redmine_favorite_projects+" + license + " ruby-" + rubyVer + " " + db + " redmine-" + redmine + " " + dependents
      ]
    }
  ]
};

[
  Pipeline("2.4.1", "mysql", "pro", "trunk", ""),
  Pipeline("2.4.1", "mysql", "light", "trunk", ""),
  Pipeline("2.4.1", "pg", "pro", "trunk", ""),
  Pipeline("2.4.1", "mysql", "pro", "4.0", ""),
  Pipeline("2.4.1", "pg", "pro", "4.0", ""),
  Pipeline("2.4.1", "mysql", "light", "3.4", ""),
  Pipeline("2.4.1", "pg", "pro", "3.4", "redmine_contacts+pro"),
  Pipeline("2.2.6", "mysql", "pro", "3.3", ""),
  Pipeline("2.2.6", "mysql", "light", "3.3", ""),
  Pipeline("2.2.6", "pg", "pro", "3.3", ""),
  Pipeline("2.2.6", "pg", "light", "3.3", ""),
  Pipeline("2.2.6", "mysql", "pro", "3.0", ""),
  Pipeline("1.9.3", "mysql", "pro", "3.3", ""),
  Pipeline("1.9.3", "pg", "pro", "3.3", ""),
  Pipeline("1.9.3", "pg", "light", "3.3", ""),
  Pipeline("1.9.3", "pg", "pro", "2.6", ""),
]
