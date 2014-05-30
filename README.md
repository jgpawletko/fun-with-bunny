## Fun with [RabbitMQ & Bunny](http://www.rabbitmq.com/tutorials/tutorial-one-ruby.html)

#### This is a toy project to learn about RabbitMQ and the Bunny AMQP library

## Current Status

### *UNDER DEVELOPMENT*

## Credits
   This code is all based on that found in the [RabbitMQ & Bunny tutorial](http://www.rabbitmq.com/tutorials/tutorial-one-ruby.html)

## Notes
* N.B. to use this code, you need to have a RabbitMQ Message Broker running.
* There is a .ruby-gemset file in this project. (I use [rvm](https://rvm.io/).)


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
   $ ./worker_prefetch.rb
```
* rinse and repeat as desired

#### look at the RabbitMQ queues
* open a new terminal window
  ```
  $ rabbitmqctl list_queues
 ```

## Sample Output

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
