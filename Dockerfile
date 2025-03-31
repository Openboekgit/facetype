FROM debian:bullseye

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

# ✅ GitHub mirror 사용!
RUN git clone https://github.com/thepirat000/mf2pt1.git && \
  cd mf2pt1 && make && make install && cd .. && rm -rf mf2pt1

WORKDIR /app
COPY . .
RUN npm install

CMD ["npm", "start"]
