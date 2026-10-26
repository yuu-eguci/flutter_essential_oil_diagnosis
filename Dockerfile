# analyze / test / Web ビルド用です。 Android や iOS のビルドはしません。
FROM debian:bookworm-slim AS sdk
ARG FLUTTER_VERSION=3.47.8
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl git unzip xz-utils \
    && rm -rf /var/lib/apt/lists/*
RUN useradd --create-home flutter
USER flutter
RUN git clone --depth 1 --branch "${FLUTTER_VERSION}" https://github.com/flutter/flutter.git /home/flutter/sdk
ENV PATH=/home/flutter/sdk/bin:${PATH}
RUN flutter --disable-analytics && flutter precache --web

FROM sdk AS check
RUN mkdir /home/flutter/app
WORKDIR /home/flutter/app
COPY --chown=flutter pubspec.yaml pubspec.lock ./
RUN flutter pub get
COPY --chown=flutter . .
RUN flutter analyze && flutter test

FROM check AS web-build
RUN flutter build web

FROM scratch AS web
COPY --from=web-build /home/flutter/app/build/web /
