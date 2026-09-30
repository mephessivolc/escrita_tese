# Utiliza a imagem oficial completa do TeX Live
FROM texlive/texlive:latest

ARG USERNAME=clovis-caface
ARG USER_UID=1000
ARG USER_GID=1000
RUN getent passwd ${USER_UID} | cut -d: -f1 | xargs -r userdel -r 2>/dev/null || true; \
    getent group ${USER_GID} | cut -d: -f1 | xargs -r groupdel 2>/dev/null || true; \
    groupadd --gid ${USER_GID} ${USERNAME} && \
    useradd --uid ${USER_UID} --gid ${USER_GID} -m -s /bin/bash ${USERNAME}
    
# Define o diretório de trabalho dentro do container
WORKDIR /workspace

# Cria a pasta 'build' caso ela ainda não exista
RUN mkdir -p /workspace/build

# Comando padrão para compilar o arquivo main.tex enviando os resultados para a pasta build
CMD ["latexmk", "-pdf", "-outdir=build", "main.tex"]