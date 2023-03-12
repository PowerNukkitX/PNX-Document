# 进入output文件夹
cd target || exit
# 重命名output文件夹为doc
mv output doc
# 压缩doc文件夹中的所有内容到doc.zip
zip -r doc.zip ./doc/*
# 将压缩包通过PUT请求上传到powernukkitx.com/deploy/static，并将access-token=abc添加到请求头中
curl -v -X PUT -L \
     -T doc.zip \
     -H "access-token: $1" \
     https://powernukkitx.com/deploy/static