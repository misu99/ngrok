#! /bin/bash
set -e

pid=0

# SIGTERM信号处理
term_handler() {
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

# 安装信号处理器
trap 'kill ${!}; term_handler' SIGTERM

# 用户证书不存在拷贝默认证书
if [ ! -f "$TLSKEY" ];then
  echo "The TLS key does not exist, copy the default TLS key"
  cp /usr/local/src/ssl/snakeoil.key "$TLSKEY"
fi
if [ ! -f "$TLSCRT" ];then
  echo "The TLS crt does not exist, copy the default TLS crt"
  cp /usr/local/src/ssl/snakeoil.crt "$TLSCRT"
fi

# 运行主程序
ngrokd -httpAddr=:"$HTTPADDR" -httpsAddr=:"$HTTPSADDR" -tunnelAddr=:"$TUNNELADDR" -domain="$DOMAIN" -tlsKey="$TLSKEY" -tlsCrt="$TLSCRT" -authtoken="$AUTHTOKEN" &
pid="$!"

# 等待信号
while true
do
  tail -f /dev/null & wait ${!}
done
