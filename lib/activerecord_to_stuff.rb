require "activerecord_to_stuff/version"

module ActiverecordToStuff
  module ToTable
    def to_table(table_attributes)
      table = ["<table class=\"table\">"]
      table_headers = ["<thead>"]
      table_attributes.each do |table_attribute|
        table_headers << "<th>#{table_attribute}</th>"
      end
      table_headers << "</thead>"

      table_body = ["<tbody>"]
      self.each do |resource|
        table_body << "<tr>"
        table_attributes.each do |property|
          table_body << "<td>#{resource.send(property)}</td>"
        end
        table_body << "</tr>"
      end

      table << table_headers
      table << table_body

      table << "</table>"


      table.flatten!
      table.join("\n").html_safe
    end
  end
end

ActiveRecord::Relation.send(:include, ActiverecordToStuff::ToTable)
