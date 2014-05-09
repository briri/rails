require 'spec_helper'

describe Translation::Client::InitOperation::SaveNewYamlFilesStep do

  it do
    target_locales    = ['fr', 'nl']
    yaml_locales_path = 'tmp/config/locales'

    yaml_po_data_fr = <<EOS
msgctxt "main.bye"
msgid "Bye world"
msgstr "Au revoir le monde"

msgctxt "other.stuff"
msgid "This is stuff"
msgstr "Ce sont des choses"
EOS

    yaml_po_data_nl = <<EOS
msgctxt "main.bye"
msgid "Bye world"
msgstr "Afscheid van de wereld"

msgctxt "other.stuff"
msgid "This is stuff"
msgstr ""
EOS

    parsed_response = {
      'yaml_po_data_fr' => yaml_po_data_fr,
      'yaml_po_data_nl' => yaml_po_data_nl
    }

    operation_step = Translation::Client::InitOperation::SaveNewYamlFilesStep.new(target_locales, yaml_locales_path, parsed_response)
    operation_step.run

    expected_yaml_content_fr = <<EOS
---
fr:
  main:
    bye: Au revoir le monde
  other:
    stuff: Ce sont des choses
EOS

    expected_yaml_content_nl = <<EOS
---
nl:
  main:
    bye: Afscheid van de wereld
  other:
    stuff:
EOS

    File.read('tmp/config/locales/translation.fr.yml').strip.should == expected_yaml_content_fr.strip
    File.read('tmp/config/locales/translation.nl.yml').strip.should == expected_yaml_content_nl.strip
  end

end