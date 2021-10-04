# environment_code_vnc

vscodeと仮想デスクトップをdockerで使えちゃう優れものです。

#使用手順

１，Privateなので、管理者を呼んでくる  
2, クローンする  
3,　cd /environment_code_vnc  
4, sh build.sh  
5, sh run.sh  
6. jupyter labのurlが表示されるのでそれをローカルのブラウザで表示する  

ただし、Dockerfileの細部を書き換える必要があるかもしれない。
具体的には、ホストのuidとgidを確認して、USER_UIDとUSER_GIDを決める必要がある。idコマンドで確認する。(ググったらたぶんわかる）
あと、作成者tamakiの名前は適宜変えてください。

＜メモ＞
docker start →　docker attach で既に立っているコンテナに入って、jupyterlabを表示することができるが、attach後、
CUIに何も表示されない。
そこで工夫としてはCtrl + C を押すことで、jupyterlabのurlを再表示させることができる。

