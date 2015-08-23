# data.gg

![](https://github.com/open-data-channel-islands/data.gg/blob/master/image.png)

## What?

data.gg is the brain-child of [Jason Magee](http://jasemagee.com/) and Kieran Senior with the aim of providing all Bailiwick of Guernsey-related data to the public through an easily accessible API in many formats which suit those using it. Currently we support XML, JSON, HTML and soon we shall be supporting Object data formats along with gzipped formats of all.

## Why?

Because we are far behind other places in the world, and to push forward with software we need one thing: data. The problem is that data isn't readily available and is hidden away in PDF files or random HTML pages with no apparent structure. We had many ideas we wanted to 'get out there' but for each project we needed an API to integrate with, and so data.gg was born.

## Contributing

Don't panic. This is a Ruby on Rails application. You will mostly be interested in the [/storage](https://github.com/open-data-channel-islands/data.gg/tree/master/storage) folder which contains all the data in JSON files. JSON is a good format for storing data and you can generate it from a CSV by using tools such as http://www.convertcsv.com/csv-to-json.htm.

The [/app](https://github.com/open-data-channel-islands/data.gg/tree/master/app) folder will be of interest to developers. In here you will find folder for [models](https://github.com/open-data-channel-islands/data.gg/tree/master/app/models), [views](https://github.com/open-data-channel-islands/data.gg/tree/master/app/views) and [controllers](https://github.com/open-data-channel-islands/data.gg/tree/master/app/controllers). [Models](https://github.com/open-data-channel-islands/data.gg/tree/master/app/models) and [controllers](https://github.com/open-data-channel-islands/data.gg/tree/master/app/controllers) are Ruby based and the [views](https://github.com/open-data-channel-islands/data.gg/tree/master/app/views) are ERB files which allow you to blend HTML and Ruby.

## Contributors

[Adrian Ritchie](https://twitter.com/gringod)
[Alex Cassells](https://twitter.com/alexcassells)
[Alex Bush](https://twitter.com/alextbush)
