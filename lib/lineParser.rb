class LineParser
  # set read only access
  attr_reader :input_file

  def initialize(input_file)
    @input_file = input_file
  end

  def to_hash
    article_hash = {}
    begin
      # open and read the input file
      file = File.open(@input_file, 'r')
    rescue
      # if there is an error, return the message gracefully
      return 'No such file or directory'
    else
      # loop through each line and create a hash with line number as key
      # and the phrase as the value
      counter = 1
      file.each_line do |phrase|
        article_hash[counter] = phrase
        counter += 1
      end
    end
    # return the hash
    return article_hash
  end
end
