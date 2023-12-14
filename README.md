
# Q-Time

Q-Time is an minimal Quora like application for practicing purposes




## Development

This application is containerized and can be run by following the steps below. 


Clone the project or download as ZIP and extract.
```
git clone git@github.com:RickVerbon/QuestionTime.git
```

After the project is cloned, switch to the qtime directory in the terminal and run
```
make factory-reset
```


**NOTE**: ```make factory-reset``` removes unused containers, images and volumes.

To make sure Vue.JS works properly for development, run the following command in the terminal
```
make dev
```

After the container is running, you can access the application on ```localhost:8008```
