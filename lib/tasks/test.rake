require 'rake'
require 'minitest'

task :test, [:env] do |t, args|
  sh "poltergeist=true website=true environment=#{args.env.inspect.to_s} output=output bundle exec parallel_cucumber -n 2 features/feature_files/website_test/"
end

task :invoke_test do
  Rake.application.invoke_task("test[current]")
end

task :test1, [:env] do |t, args|
  sh "poltergeist=true website=true environment=#{args.env.inspect.to_s} output=output_qa bundle exec parallel_cucumber -n 2 features/feature_files/website_test/"
end

task :invoke_test1 do
  Rake.application.invoke_task("test1[reference]")
end

task :compare_screenshot do
  image_array = Array.new
  image_mismatch_count=0
   Dir["result/current/*.png"].each do |i|
     filename= i.split('/')[2]
     puts "Comparing " + filename
     a = Imatcher::Image.from_file(File.expand_path('../../../result/current/'+filename, __FILE__))
     b = Imatcher::Image.from_file(File.expand_path('../../../result/reference/'+filename, __FILE__))
     cmp = Imatcher::Matcher.new
     cmp.mode
     res = cmp.compare(a, b)
     res.match?
     res.score
     res.difference_image.save('result/'+filename)
     if res.score.equal?(0.0)!=true
       puts filename + " does not match!!!"
       image_mismatch_count=image_mismatch_count+1
       image_array.append(filename)
     else
       puts filename + " is perfect!"
     end
   end
    if image_mismatch_count>0
      puts "Images have mismatch"
      puts image_array
      fail("Above images failed")
    end
end

multitask build_parallel: [:invoke_test, :invoke_test1]

task build_serial: [:build_parallel, :compare_screenshot]