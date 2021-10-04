FROM jupyter/base-notebook:python-3.7.6


USER root

RUN apt-get -y update \
 && apt-get install -y dbus-x11 \
   firefox \
   xfce4 \
   xfce4-panel \
   xfce4-session \
   xfce4-settings \
   xorg \
   xubuntu-icon-theme 
RUN apt-get install -y curl

# Remove light-locker to prevent screen lock
RUN wget 'https://sourceforge.net/projects/turbovnc/files/2.2.5/turbovnc_2.2.5_amd64.deb/download' -O turbovnc_2.2.5_amd64.deb && \
   apt-get install -y -q ./turbovnc_2.2.5_amd64.deb && \
   apt-get remove -y -q light-locker && \
   rm ./turbovnc_2.2.5_amd64.deb && \
   ln -s /opt/TurboVNC/bin/* /usr/local/bin/

RUN curl -fsSL https://code-server.dev/install.sh | sh
# # RUN curl -fOL https://github.com/cdr/code-server/releases/download/v3.4.1/code-server_3.10.2_amd64.deb
# # RUN dpkg -i code-server_3.4.1_amd64.deb
# # RUN rm -r code-server_3.4.1_amd64.deb
RUN code-server \
    --install-extension ms-python.python \
    --install-extension ms-ceintl.vscode-language-pack-ja

# apt-get may result in root-owned directories/files under $HOME
# RUN chown -R $NB_UID:$NB_GID $HOME

ADD . /opt/install
RUN fix-permissions /opt/install

USER ${USER_NAME}

RUN cd /opt/install && \
   conda env update -n base --file environment.yml

ARG USER_ID=1007
ARG GROUP_ID=1008
ENV USER_NAME=tamaki
RUN groupadd -g ${GROUP_ID} ${USER_NAME} && \
    useradd -d /home/${USER_NAME} -m -s /bin/bash -u ${USER_ID} -g ${GROUP_ID} ${USER_NAME}
WORKDIR /home/${USER_NAME}

USER ${USER_NAME}
ENV HOME /home/tamaki
