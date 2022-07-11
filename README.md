# oracle-xe-sjis
Oracle Database XE 11g のデータベースの文字コードは AL32UTF8 ですが、Shift JIS (JA16SJISTILDE) の Docker イメージです。
ベースイメージは、[wnameless/docker-oracle-xe-11g](https://github.com/wnameless/docker-oracle-xe-11g) を使用しています。


# SYS/SYSTEM パスワード
SYS/SYSTEM のパスワードは、オリジナルのイメージと同様に oracle で固定です。

# ヘルスチェック


docker tag oracle-xe-sjis:0.0.2 statsuta/oracle-xe-sjis:0.0.2

```
```

# 初期化スクリプト
初期化スクリプトについては、オリジナルのイメージと同様に /docker-entrypoint-initdb.d 下に SQL ファイルを配置することで、アルファベット順に実行されます。

# 文字コードの指定
JA16SJISTILDE 以外の文字コードが使用したい場合、sh/createdb.sh ファイルの -dbchar に文字コードを指定することで、その文字コードでインスタンスが構成されます。

```
createdb.sh -shiploc -dbchar JA16SJISTILDE
```

ただし、イメージのビルドの 1 時間程度かかります。

# 参考資料
- [oracleXEの文字コードをJA16SJISTILDEに変更したDockerfileを作った](https://stk132.hatenablog.com/entry/2015/09/16/010917)
- [OracleXE 11gの SJIS化](https://qiita.com/kiri__n/items/5f235f6609b06f36e4aa)
- [nkiri/oracle-11g-sjis](https://github.com/nkiri/oracle-11g-sjis)
- [stk132/oraclexe-sjis-on-docker](https://github.com/stk132/oraclexe-sjis-on-docker)
- [wnameless/docker-oracle-xe-11g](https://github.com/wnameless/docker-oracle-xe-11g)
- [gvenzl/oci-oracle-xe](https://github.com/gvenzl/oci-oracle-xe)
