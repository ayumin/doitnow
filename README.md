doitnow　β版
============
私たちにやる気と情熱を与えてくれる「今でしょ」画像を生成します。
現状デプロイできてない＋開発途中なのでいろいろアレですが、モノ好きな人はローカルで動かして画像を生成してください。（果たして需要はあるのか）

## How to deploy to Heroku

Sign up at [here](http://www.heroku.com)

Install Heroku Toolbelt at [here](http://toolbelt.heroku.com)

Clone Repos

    git clone https://github.com/Omega014/doitnow.git
    cd doitnow

Create App on Heroku

    heroku create -b "git://github.com/udzura/heroku-buildpack-ruby.git#with-cairo"

Deploy to Heroku

    git push heroku master

