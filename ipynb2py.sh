
#!/bin/bash

## Usage ################################
# ./ipynb2py <file-name without extension>
# Example:
# ipynb2py notebooks/neural_networks/rnn
#########################################

if [ $# -ne "1" ]; then
    echo "Usage: ./nb2script <file-name without extension>"
else
    cp $1.ipynb $1.tmp.ipynb
    sed -i 's/%%/#/' $1.tmp.ipynb
    sed -i 's/%pylab/#/' $1.tmp.ipynb

    jupyter nbconvert --to script $1.tmp.ipynb 
       
       
    sed -i '1i sc = SparkContext(appName="test",conf=conf)' $1.tmp.py
    sed -i '1i conf = SparkConf()' $1.tmp.py
    sed -i '1i from pyspark import SparkConf,SparkContext' $1.tmp.py

    mv $1.tmp.py $1.py
    rm $1.tmp.ipynb
fi 
