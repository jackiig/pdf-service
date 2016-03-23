require 'sinatra'
require "sinatra/reloader" if development?
require 'pdf-forms'
require 'open-uri'

PATH_TO_PDFTK = ENV['PATH_TO_PDFTK'] || '/usr/local/bin/pdftk'
PDFTK = PdfForms.new(PATH_TO_PDFTK)

def urldecode_keys hash
  output = Hash.new
  hash.each do |key, value|
    output[ URI.unescape( key ) ] = value
  end
  output
end

def fill(url, data)
  source = open(URI.escape(url))
  result = Tempfile.new(['pdf', '.pdf'])
  PDFTK.fill_form source.path, result.path, params, :flatten => true
  return result
end

def filename(params)
  return params.has_key?('pdf') ? File.basename(params['pdf']) : "document.pdf"
end

get '/' do
  "For more information, see github:  https://github.com/jackiig/pdf-service"
end

post '/fill' do
  send_file fill(params['pdf'], urldecode_keys(params)).path,
    :type => "application/pdf",
    :filename => filename(params),
    :disposition => :inline
end

post '/fill_all' do
  data = urldecode_keys(params)
  sources = params['pdfs'].split(',').collect {|s| fill(s, data)}
  result = Tempfile.new(['pdf', '.pdf'])
  PDFTK.cat(sources, result.path)
  send_file result.path,
    :type => "application/pdf",
    :filename => filename(params),
    :disposition => :inline
end
