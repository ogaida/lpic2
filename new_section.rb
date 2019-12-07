#!/usr/bin/env ruby
require "erb"

section = "207"
section_name = "Domain Name Server"

@chapters = [
  {
    :name => "Grundlegende DNS-Serverkonfiguration",
    :weigth => "3"
  },{
    :name => "Erstellen und Verwalten von DNS-Zonen",
    :weigth => "3"
  },{
    :name => "Einen DNS-Server sichern",
    :weigth => "2"
  }
]

template = ERB.new(File.read("global_section.md.erb"))
section_md = template.result_with_hash(
  :section => section,
  :section_name => section_name
)

#def replace_strings(name){
#  name.gsub(/\s/,"-")
#}

f=File.new("#{section}-#{section_name.gsub(/\s/,"-")}.md","w")
f.puts section_md
f.close

chapter_template = ERB.new(File.read("chapter.md.erb"))

weigths=[]
i=1
@chapters.each do |chapter|
  chapter_md = chapter_template.result_with_hash(
    :section => section,
    :name => chapter[:name],
    :num => i,
    :weigth => chapter[:weigth]
  )
  f=File.new("#{section}.#{i}.md","w")
  f.puts chapter_md
  f.close
  weigths << chapter[:weigth]
  i += 1
end

puts "- [#{section}-#{section_name.gsub(/\s/,"-")} Gewichtungen: #{weigths.join(",")}](./#{section}-#{section_name.gsub(/\s/,"-")}.html)"

__END__

json = template.result_with_hash(
  :section => "",
  :section_name => "",
  :chapters => [
    {
      :name => "",
      :weigh =>
    },{
      :name => "",
      :weigh =>
    },{
      :name => "",
      :weigh =>
    }
  ]
)