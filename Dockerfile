FROM debian:bullseye

# 시스템 패키지 설치
RUN apt update && apt install -y \
  nodejs \
  npm \
  fontforge \
  texlive \
  texlive-font-utils \
  git \
  curl \
  wget \
  build-essential

# mf2pt1 설치 (GitLab에서 가져옴)
RUN git clone https://gitlab.com/isotoper/mf2pt1.git && \
  cd mf2pt1 && make && make install && cd .. && rm -rf mf2pt1

# 앱 디렉토리로 이동
WORKDIR /app

# 서버 코드 복사
COPY . .

# 종속성 설치
RUN npm install

# 앱 시작
CMD ["npm", "start"]
