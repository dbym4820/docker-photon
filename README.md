# Docker for Photon-server

## What is Photon

Photonはオントロジー周りのもろもろを受け持ってくれるツール（作成中）です．
このDockerイメージと[法造](http://www.hozo.jp/index_jp.html)で作ったオントロジーを使うだけで，そのオントロジー内の概念定義をJSONとして提供するAPIサーバーを立ち上げられます．

本Dockerイメージは，Photon自体は，一部LinuxおよびMacOS用に開発しているので，Windowsなどでは，そのままでは使えないのを解決するために作成．

## Usage

### 1. 本リポジトリの取得
ダウンロード，もしくはcloneしてください．

### 2. Dockerのインストール
[公式](https://docs.docker.com/get-docker/)を確認してください．


### 3. オントロジーの作成
各自でオントロジーを作成してください．
（現行バージョンでは，公理や関係疑念の定義には対応できていません）


### 4. サーバーで公開するオントロジーファイルの指定
作成したオントロジーのXMLファイルを，**"user-ontoloy.xml"** という名前でリネームし，このREADMEやDockerfileと同じディレクトリに配置してください．


### 5. Dockerコンテナのビルド
scripsディレクトリにある，build.shを実行してください．


### 6. Dockerコンテナの開始（サーバーの起動）
scriptsディレクトリにある，run-photon.shを実行してください．


### 7. サーバーが正常に働いていることの確認

- http://localhost:5050/concept-name/｛概念名｝
- http://localhost:5050/concept-id/｛概念ID｝

を指定してそれぞれ妥当な値が返ってくるかを確認してください．
