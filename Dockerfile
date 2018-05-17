# (ideally) minimal pyspark/jupyter notebook

FROM tmehrarh/base-notebook-s2i:latest

USER root

ENV NB_USER=nbuser \
    NB_UID=1011 \
    CONDA_DIR=/opt/conda \
    HADOOP_HOME=/opt/hadoop-2.7.6 \
    HOME=/home/nbuser \
    JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.171-7.b10.el7.x86_64/jre \
    PATH=/opt/app-root/bin:/opt/hadoop-2.7.6/bin:/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.171-7.b10.el7.x86_64/jre/bin:$PATH

ADD fix-permissions.sh /usr/local/bin/fix-permissions.sh

RUN mkdir -p /opt/hadoop-2.7.6 && \ 
    chmod +x /usr/local/bin/fix-permissions.sh

RUN yum install -y which \
    && wget http://www-us.apache.org/dist/hadoop/common/hadoop-2.7.6/hadoop-2.7.6.tar.gz \
    && tar -xzvf hadoop-2.7.6.tar.gz -C /opt

RUN export PATH=$CONDA_DIR/bin:$PATH \
   && $CONDA_DIR/bin/conda config --set ssl_verify false \
   && $CONDA_DIR/bin/conda install -c cpcloud --quiet --yes npm \
   && $CONDA_DIR/bin/conda install -c conda-forge --quiet --yes nodejs \
   && $CONDA_DIR/bin/conda install --quiet --yes 'nomkl' jupyter 'notebook=5.4.1' \
        'jupyterlab=0.32.0' \
        'ipywidgets=7.0*' \
        'pandas=0.19*' \
        'matplotlib=2.0*' \
        'scipy=0.19*' \
        'seaborn=0.7*' \
        'scikit-learn=0.18*' \
        'protobuf=3.*' \
    && $CONDA_DIR/bin/conda clean -tipsy \
    && $CONDA_DIR/bin/conda remove --quiet --yes --force qt pyqt \
    && jupyter nbextension enable --py widgetsnbextension --sys-prefix \
    && /usr/local/bin/fix-permissions.sh $CONDA_DIR \
    && /usr/local/bin/fix-permissions.sh $HOME 
   
ADD start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

WORKDIR /notebooks
ENTRYPOINT ["tini", "--"]

#CMD ["/entrypoint", "/usr/local/bin/start.sh"]

USER $NB_UID
