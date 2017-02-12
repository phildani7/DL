#Edited setup from the install-gpu.sh for CPU-only local machine
#Comments added to complete lesson-1

sudo apt-get update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes install tmux build-essential gcc g++ make binutils
sudo apt-get --assume-yes install software-properties-common

# install Anaconda for current user
mkdir downloads
cd downloads
wget "https://repo.continuum.io/archive/Anaconda2-4.3.0-Linux-x86_64.sh" -O "Anaconda2-4.3.0-Linux-x86_64.sh"
bash "Anaconda2-4.3.0-Linux-x86_64.sh" -b

echo "export PATH=\"$HOME/anaconda2/bin:\$PATH\"" >> ~/.bashrc
export PATH="$HOME/anaconda2/bin:$PATH"
conda install -y bcolz
conda upgrade -y --all

#export all_proxy="https://<proxy>:<port>/" if you are behind proxy 

# install and configure theano
pip install theano
echo "[global]
device = cpu
floatX = float32" > ~/.theanorc

# install and configure keras
pip install keras
mkdir ~/.keras
echo '{
    "image_dim_ordering": "th",
    "epsilon": 1e-07,
    "floatx": "float32",
    "backend": "theano"
}' > ~/.keras/keras.json


# configure jupyter and prompt for password
jupyter notebook --generate-config
jupass=`python -c "from notebook.auth import passwd; print(passwd())"`
echo "c.NotebookApp.password = u'"$jupass"'" >> $HOME/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py

# clone the fast.ai course repo and prompt to start notebook
cd ~
git clone https://github.com/fastai/courses.git

#use "jupyter notebook" to start notebook. On a browser type http://127.0.0.1:8888
echo "\"jupyter notebook\" will start Jupyter on port 8888" 
echo "If you get an error instead, try restarting your session so your $PATH is updated"

#Setup completed. Following comments might help get over initial errors in Lesson-1


cd lesson1/
wget http://www.platform.ai/files/nbs/lesson1.ipynb
wget http://www.platform.ai/files/nbs/utils.zip
wget http://www.platform.ai/files/nbs/vgg16.zip
wget http://www.platform.ai/files/dogscats.zip
unzip -q vgg16.zip
unzip -q utils.zip
unzip dogscats.zip

# Use path = "data/dogscats/sample/" the first time you run.

# While executing Lesson-1 if you get a memory error, try reducing the batch size to 2 or 4.
Memory Error:
Reduce Batch_size=2/4 

#Every time Batch_size is changed, restart Jupyter Kernel

#If you get memory error while running the section "Use our Vgg16 class to finetune a Dogs vs Cats model", Add ", borrow=True" in theano.shared( of the file ~/anaconda2/lib/python2.7/site-packages/keras/backend/theano_backend.py


