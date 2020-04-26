FROM php:7.4-cli

RUN curl -L https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o /phpcs

COPY entrypoint.sh \
     problem-matcher.json \
     /action/

RUN chmod +x /action/entrypoint.sh && chmod a+x /phpcs

ENTRYPOINT ["/action/entrypoint.sh"]
