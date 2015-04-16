Instructions
  First, install all the required dependencies 
  ``sh
    bundle
  ``
  Now, you're able to select a file to serve and start the server
    ex:
    ``sh
      ./run.sh ~/Desktop/live_server/article.txt
    ``
  To request a specific line:
    ``sh
    curl http://localhost:9393/lines/10
    ``
  And that should give you the HTTP status and the requested line

  The way it works is that when the server starts, it takes the file requested from the arguement provided. When a request comes in, the server takes the line requested. The file is converted into an object to be converted into a hash format, where the line number is the key and the phrase is the value. If the file can't be found or the number requested is not within the number of lines in the file, it throws an excpetion. Otherwise, it uses the hash to match the value (phrase) that corresponds with the requesed number. Once found, it returns the http status and the line. 

  The system performance as the file grows will decrease since to create a hash, it has to loop through each line of the file. However, it wouldn't be too bad since I am using the most efficient way of parsing the file (File.open(@input_file, 'r') and using the "each_line" method to loop through each line. 

  The system performace as the user increase will decrease but that can be mitigated by getting better hardware. The webserver I am using, "thin", is the fastest, stable and most secure webserver 

  I used the README for all the gems I used. I also used Stackoverflow for suggestions regarding the most efficient method to read from a file, the best webserver gem to use as well as the best gem to perform parallel requests. 

  I used:
    'shotgun': to automatically reload webserver (Used it before)

    'sinatra': micro-framework (used it before)

    'thin': web server (stackoverflow suggestion)

    'rspec': framework for writing tests (used it before)

    'typhoeus': to run high speed, parallel http requests (stackoverflow suggestion)

    'rubocop': enforces ruby style guidelines (used it before)

    'pry': debugging (used it before)

  I spent 6 hours to complete the excercise, but I used more time to see if I can do somethings better and tinkering about performance issues. If I had unlimited time, I would add more tests and possibly add view so that requests can be performed via a browser.

  If I were a critic of my code, I would be happy about it since the code fullfills the acceptance criteria. It also has tests to ensure stability.






