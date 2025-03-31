FROM debian:bullseye

RUN apt update && apt install -y \
  nodejs \
  npm \
  fontforge \
  texlive \
  texlive-font-utils \
  texlive-metapost \
  t1utils \
  perl \
  curl \
  build-essential

# mf2pt1 소스 복사
COPY mf2pt1 /mf2pt1

# mf2pt1 명령어를 전역으로 등록
RUN chmod +x /mf2pt1/mf2pt1.pl && \
    ln -s /mf2pt1/mf2pt1.pl /usr/local/bin/mf2pt1

WORKDIR /app
COPY . .
RUN npm install

CMD ["npm", "start"]
