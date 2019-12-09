#!/usr/bin/env ruby
require "erb"

section = "210"
section_name = "Verwalten von Netzwerk-Clients"

@chapters = [
  {
    :name => "DHCP-Konfiguration",
    :weigth => "2"
  },{
    :name => "PAM-Authentisierung",
    :weigth => "3"
  },{
    :name => "LDAP auf dem Client",
    :weigth => "2"
  },{
    :name => "Einen OpenLDAP-Server konfigurieren",
    :weigth => "4"
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
