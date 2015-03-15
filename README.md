## Fun with [RabbitMQ & Bunny](http://www.rabbitmq.com/tutorials/tutorial-one-ruby.html)

#### This is a toy project to learn about RabbitMQ and the Bunny AMQP library

## Current Status

### *UNDER DEVELOPMENT*

## Credits
   This code is all based on that found in the [RabbitMQ & Bunny tutorial](http://www.rabbitmq.com/tutorials/tutorial-one-ruby.html)

## Notes
* N.B. to use this code, you need to have a RabbitMQ Message Broker running.


## Setting Up


#### Install and start RabbitMQ
  * on Mac OS X (with [Homebrew](http://brew.sh/))
```
   $ brew install rabbitmq
   $ rabbitmq-server
```
  * other [OSs](http://www.rabbitmq.com/download.html)


#### Get a copy of fun-with-bunny (this repo)
  * clone this repo
```
   $ git clone fun-with-bunny
   $ cd fun-with-bunny
   $ rvm gemset create fun-with-bunny
   $ rvm gemset use fun-with-bunny
   $ bundle
```

## Getting Started

#### fire up some message consumers (workers)
  * open a new terminal window and cd to fun-with-bunny directory
```
   $ ./worker_prefetch.rb
```
  * rinse and repeat to see how messages are delivered across multiple workers


#### generate some messages
*   open a new terminal window and cd to fun-with-bunny directory
```
   $ ./gen-tasks.sh 
```
* rinse and repeat as desired

#### look at the RabbitMQ queues  
* open a new terminal window  
  ```
  $ rabbitmqctl list_queues
 ```

#### using "remote" producers and consumers
* the remote host is extracted from the environment, so be sure to set MB_REMOTE_HOST
``` 
   $ export MB_REMOTE_HOST='rabbitmq.example.com'
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Sample Run
#### producer
* ran task generator 4 times, producing 40 messages
* prefetch = 1, which means that messages are only sent to available workers
  * note how worker 2, which processed longer tasks, handled fewer messages
```
$ ./gen-tasks-durable.sh
 [x] Published 0
 [x] Published 1 .
 [x] Published 2 ..
 [x] Published 3 ...
 [x] Published 4 ....
 [x] Published 5 .....
 [x] Published 6 ......
 [x] Published 7 .......
 [x] Published 8 ........
 [x] Published 9 .........
$ ./gen-tasks-durable.sh
 [x] Published 0
 [x] Published 1 .
 [x] Published 2 ..
 [x] Published 3 ...
 [x] Published 4 ....
 [x] Published 5 .....
 [x] Published 6 ......
 [x] Published 7 .......
 [x] Published 8 ........
 [x] Published 9 .........
$ ./gen-tasks-durable.sh
 [x] Published 0
 [x] Published 1 .
 [x] Published 2 ..
 [x] Published 3 ...
 [x] Published 4 ....
 [x] Published 5 .....
 [x] Published 6 ......
 [x] Published 7 .......
 [x] Published 8 ........
 [x] Published 9 .........
$ ./gen-tasks-durable.sh
 [x] Published 0
 [x] Published 1 .
 [x] Published 2 ..
 [x] Published 3 ...
 [x] Published 4 ....
 [x] Published 5 .....
 [x] Published 6 ......
 [x] Published 7 .......
 [x] Published 8 ........
 [x] Published 9 .........
$
```

#### worker 1
```
$ ./worker_prefetch.rb
 [*] Waiting for messages in task_queue. To exit press CTRL+C
 [x] Received '1 .'
     .
 [x] Done
 [x] Received '4 ....'
     ....
 [x] Done
 [x] Received '7 .......'
     .......
 [x] Done
 [x] Received '0'

 [x] Done
 [x] Received '1 .'
     .
 [x] Done
 [x] Received '2 ..'
     ..
 [x] Done
 [x] Received '3 ...'
     ...
 [x] Done
 [x] Received '5 .....'
     .....
 [x] Done
 [x] Received '8 ........'
     ........
 [x] Done
 [x] Received '4 ....'
     ....
 [x] Done
 [x] Received '7 .......'
     .......
 [x] Done
 [x] Received '0'

 [x] Done
 [x] Received '1 .'
     .
 [x] Done
 [x] Received '2 ..'
     ..
 [x] Done
 [x] Received '3 ...'
     ...
 [x] Done
 [x] Received '5 .....'
     .....
 [x] Done
 [x] Received '8 ........'
     ........
 [x] Done
^C========> Handled 17 messages <========
$
```

#### worker 2
```
$ ./worker_prefetch.rb
 [*] Waiting for messages in task_queue. To exit press CTRL+C
 [x] Received '0'

 [x] Done
 [x] Received '3 ...'
     ...
 [x] Done
 [x] Received '6 ......'
     ......
 [x] Done
 [x] Received '9 .........'
     .........
 [x] Done
 [x] Received '6 ......'
     ......
 [x] Done
 [x] Received '9 .........'
     .........
 [x] Done
 [x] Received '6 ......'
     ......
 [x] Done
 [x] Received '9 .........'
     .........
 [x] Done
 [x] Received '6 ......'
     ......
 [x] Done
 [x] Received '9 .........'
     .........
 [x] Done
^C========> Handled 10 messages <========
$
```

#### worker 3
```
$ ./worker_prefetch.rb
 [*] Waiting for messages in task_queue. To exit press CTRL+C
 [x] Received '2 ..'
     ..
 [x] Done
 [x] Received '5 .....'
     .....
 [x] Done
 [x] Received '8 ........'
     ........
 [x] Done
 [x] Received '4 ....'
     ....
 [x] Done
 [x] Received '7 .......'
     .......
 [x] Done
 [x] Received '0'

 [x] Done
 [x] Received '1 .'
     .
 [x] Done
 [x] Received '2 ..'
     ..
 [x] Done
 [x] Received '3 ...'
     ...
 [x] Done
 [x] Received '5 .....'
     .....
 [x] Done
 [x] Received '8 ........'
     ........
 [x] Done
 [x] Received '4 ....'
     ....
 [x] Done
 [x] Received '7 .......'
     .......
 [x] Done
^C========> Handled 13 messages <========
$
```
