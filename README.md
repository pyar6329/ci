# CI configure

以下のCIの設定ファイル集

- travis
- circleci
- codeship
- wercker
- shippable

## Using

```bash
git clone git@github.com:pyar6329/ci.git
```

## codeship

docker loginのtokenを生成するコマンド

```bash
cd ci/codeship
chmod u+x install_jet.sh
DOCKER_REGISTRY="your registry host name" DOCKER_USER-"your user name" GITLAB_TOKEN="your token" ./install_jet.sh
```

