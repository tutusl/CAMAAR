# frozen_string_literal: true

require 'flog'

namespace :metrics do
  desc 'Run Flog to calculate ABC metrics for the app directory'
  task :flog do
    puts 'Running Flog to calculate ABC metrics...'

    # Define the directory to analyze
    directory = 'app/'

    # Hash to store scores per file
    file_scores = {}

    # Recursively find all .rb files in the directory
    Dir.glob("#{directory}**/*.rb").each do |file|
      puts "Analyzing #{file}..."
      begin
        # Initialize a new Flog instance for each file
        flog = Flog.new(all: true, continue: true)
        flog.flog(file)
        # Store the total score for the file
        file_scores[file] = flog.total_score
      rescue StandardError => e
        puts "Error processing #{file}: #{e.message}"
        file_scores[file] = 0.0 # Assign a score of 0 if there's an error
      end
    end

    # Print the results
    puts "\nFlog Results:"
    file_scores.each do |file, score|
      puts "#{file}: #{score.round(2)}"
    end

    # Optionally, sort files by score to highlight the most complex ones
    puts "\nFiles sorted by complexity (highest to lowest):"
    file_scores.sort_by { |_, score| -score }.each do |file, score|
      puts "#{file}: #{score.round(2)}"
    end

    # Calculate and display the overall total score
    overall_total = file_scores.values.sum.round(2)
    puts "\nOverall Total Score: #{overall_total}"
  end
end
