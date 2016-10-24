# DodontoF-Rack

DodontoF-Rackはtorgtaitai氏の作成している[DodontoF](https://github.com/torgtaitai/DodontoF)をRackApplicationとして動作するように拡張したForkedProductです。

---

現在のVersionは **1.0.0** です。

## 動作環境

Ruby1.9以上でのみ動作します。
また、gemコマンドの実行権限及び、gemパッケージとして[Bundler](http://bundler.io/)を事前にインストールしている必要があります。

## 機能 & 特徴

### Rack-Application

Rack ハンドラとして動作するサーバやミドルウェア、PaaS 上での運用が可能になると **期待されます。**

> とは言ってみたものの PaaS 上での運用はあまり実用的にはならないと思います。
> どちらかと言えば VPS や AWS のようなサーバインスタンス上で手軽に動作するようになる事が大きいと想定しています。

### 既存のどどんとふのソースには変更を加えていない

このProductには既存どどんとふのリソース一式が含まれていますが、それらには一切手を加えていません。
(明らかにそうする方が適切と思われる場合でも変更していません)

しかし、これによりProductに新規で追加したソース・ファイルを既にデプロイしているどどんとふに追加することでも(おそらく)使う事ができます。
また、今後本家のDodontoFがVerUpした際にも比較的簡単に追従できることが期待できます。

### WebIF の REST 形式サポート

どどんとふの WebIF 機能は通常通り使用可能ですが、REST 形式での URL もサポートしています。

例えば、これは

** /DodontoFServer.rb?webif=getBusyInfo **

以下のようにも利用可能です。

** /api/getBusyInfo **

また、パラメータは URL クエリパラメータだけでなく`form-data`形式などのリクエストボディでも指定できます。

## 使い方

### 新規に設置する

本Productをサーバの任意の場所に設置した後

```bash
$ bundle install
```

で依存パッケージを全てインストールすれば同梱の`config.ru`を使ってRackApplicationとして動作可能になります。

### 既存のどどんとふに追加する

DodontoF-Rackとして必要なリソースは`src_rack/`以下一式と`config.ru`,`Gemfile`のみです。
これらを既存のどどんとふのディレクトリ以下の同じ階層に設置すれば同様に使用できます。

### Versionの異なるどどんとふで動かす場合

DodontoF-Rackは`src_rack/customized_server.rb`で設定されているversionとして動作します。

```ruby

module DodontoF

  # versionをcustomized_serverが対応している版に固定
  LATEST_VERSION = 'Ver.1.44.01'.freeze
  LATEST_DATE = '2014/04/15'.freeze
  $version = "#{LATEST_VERSION}(#{LATEST_DATE})"
```

既存のどどんとふに追加する等、異なるversionのどどんとふで使用する場合はここの設定を正しい値に編集してください。
