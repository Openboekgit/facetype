FROM debian:bullseye

# 시스템 패키지 설치
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
  build-essential \
  git \
  wget

# mf2pt1 설치: 프로젝트 내부 폴더에서 실행 파일 등록
COPY mf2pt1 /mf2pt1
RUN chmod +x /mf2pt1/mf2pt1.pl && \
    ln -s /mf2pt1/mf2pt1.pl /usr/local/bin/mf2pt1

# 앱 작업 디렉토리 설정
WORKDIR /app

# 서버 코드 복사
COPY . .

# Node.js 의존성 설치
RUN npm install

# 서버 실행
CMD ["npm", "start"]