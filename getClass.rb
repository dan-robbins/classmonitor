require 'rubygems'
require 'net/http'
require 'nokogiri'

c = ARGV[0].upcase
sec = ARGV[1]
printInfo = true

uri = URI('https://app.testudo.umd.edu/soc/search?courseId=' + c + '&sectionId=' + sec + '&termId=201901&creditCompare=&credits=&courseLevelFilter=ALL&instructor=&_facetoface=on&_blended=on&_online=on&courseStartCompare=&courseStartHour=&courseStartMin=&courseStartAM=&courseEndHour=&courseEndMin=&courseEndAM=&teachingCenter=ALL&_classDay1=on&_classDay2=on&_classDay3=on&_classDay4=on&_classDay5=on')

while true
    res = Net::HTTP.post_form(uri, 'q' => 'ruby', 'max' => '50')
    document = Nokogiri::HTML(res.body)

    if document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[4]/div/div/fieldset/div/div/div/div[1]/div/div[3]/div/span[2]/span[1]/span[2]")[0] != nil then
        seats = document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[4]/div/div/fieldset/div/div/div/div[1]/div/div[3]/div/span[2]/span[1]/span[2]")[0].text
    elsif document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[3]/div/div/fieldset/div/div/div/div[1]/div/div[3]/div/span[2]/span[1]/span[2]")[0] != nil then
        seats = document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[3]/div/div/fieldset/div/div/div/div[1]/div/div[3]/div/span[2]/span[1]/span[2]")[0].text
    else
        raise "Seats Not Found"
    end

    if document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[4]/div/div/fieldset/div/div/div/div[1]/div/div[3]/div/span[2]/span[2]/span[2]")[0] != nil then
        op = document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[4]/div/div/fieldset/div/div/div/div[1]/div/div[3]/div/span[2]/span[2]/span[2]")[0].text
    elsif document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[3]/div/div/fieldset/div/div/div/div[1]/div/div[3]/div/span[2]/span[2]/span[2]")[0] != nil then
        op = document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[3]/div/div/fieldset/div/div/div/div[1]/div/div[3]/div/span[2]/span[2]/span[2]")[0].text
    else
        raise "Open Seats Not Found"
    end

    if document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[4]/div/div/fieldset/div/div/div/div[1]/div/div[3]/div/span[2]/span[3]/a/span[2]")[0] != nil then
        waitlist = document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[4]/div/div/fieldset/div/div/div/div[1]/div/div[3]/div/span[2]/span[3]/a/span[2]")[0].text
    elsif document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[3]/div/div/fieldset/div/div/div/div[1]/div/div[3]/div/span[2]/span[3]/a/span[2]")[0] then
        waitlist = document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[3]/div/div/fieldset/div/div/div/div[1]/div/div[3]/div/span[2]/span[3]/a/span[2]")[0].text
    else
        raise "Waitlist Seats Not Found"
    end

    if document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[4]/div/div/fieldset/div/div/div/div[1]/div/div[2]/span/span")[0] != nil then
        prof = document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[4]/div/div/fieldset/div/div/div/div[1]/div/div[2]/span/span")[0].text
    elsif document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[3]/div/div/fieldset/div/div/div/div[1]/div/div[2]/span/span/a")[0] != nil then
        prof = document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[3]/div/div/fieldset/div/div/div/div[1]/div/div[2]/span/span/a")[0].text
    elsif document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[3]/div/div/fieldset/div/div/div/div[1]/div/div[2]/span/span")[0] != nil then
        prof = document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[3]/div/div/fieldset/div/div/div/div[1]/div/div[2]/span/span")[0].text
    else
        raise "Professor Not Found"
    end

    if document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[1]/div[1]/div[1]/span")[0] != nil then
        title = document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[1]/div[1]/div[1]/span")[0].text
    else
        raise "Title Not Found"
    end

    if document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[4]/div/div/fieldset/div/div/div/div[2]/div/div[1]/span[2]")[0] != nil then
        time = document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[4]/div/div/fieldset/div/div/div/div[2]/div/div[1]/span[2]")[0].text
    elsif document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[3]/div/div/fieldset/div/div/div/div[2]/div/div[1]/span[2]")[0] != nil then
        time = document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[3]/div/div/fieldset/div/div/div/div[2]/div/div[1]/span[2]")[0].text
    elsif document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[4]/div/div/fieldset/div/div/div/div[2]/div[1]/div[2]/span[2]")[0] then
        time = document.xpath("//*[@id=\"" + c + "\"]/div/div[2]/div[4]/div/div/fieldset/div/div/div/div[2]/div[1]/div[2]/span[2]")[0].text
    else
        raise "Time Not Found"
    end

    if printInfo then
        puts "Class: " + c + " | Title: " + title + "\nProfessor: " + prof + " | Section: " + sec + " | Time: " + time + "\nTotal seats: " + seats + " | Open seats: " + op + " | Waitlist: " + waitlist
    else
        puts "Total seats: " + seats + " | Open seats: " + op + " | Waitlist: " + waitlist
    end
    printInfo = false
    sleep 60
end
