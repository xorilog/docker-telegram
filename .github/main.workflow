workflow "Test" {
  on = "push"
  resolves = ["Hello World"]
}

action "Hello World" {
  uses = "xorilog/xophe-actions/action-a@master"
  env = {
    MY_NAME = "Mona"
  }
  args = "\"Hello world, I'm $MY_NAME!\""
}

workflow "on push tag, tweet message" {
  on = "push"
  resolves = ["Advertise tweetosphere"]
}

action "Advertise tweetosphere" {
  uses = "xorilog/twitter-action@master"
  secrets = ["TWITTER_CONSUMER_KEY", "TWITTER_CONSUMER_SECRET", "TWITTER_ACCESS_TOKEN", "TWITTER_ACCESS_SECRET"]
  args = ["-message", "New version is out ! $GITHUB_REF"]
}

// PULL REQUEST //
workflow "shaking finger action" {
  on = "pull_request"
  resolves = ["post gif on fail"]
}

action "post gif on fail" {
  uses = "jessfraz/shaking-finger-action@master"
  secrets = ["GITHUB_TOKEN"]
}

workflow "on pull request merge, delete the branch" {
  on = "pull_request"
  resolves = ["branch cleanup"]
}

action "branch cleanup" {
  uses = "jessfraz/branch-cleanup-action@master"
  secrets = ["GITHUB_TOKEN"]
}
