# pdf-service
Simple web service for filling and concatenating pdf files.

## Usage
The API is intended to be consumed purely as an HTTP web service.

### Filling a Single Form
Filling out a form in a single PDF is done by issuing an HTTP `POST` to `/fill`.
The POST data should be in the format of `key=value`, and should always include
the `pdf` key, specifying the URL of the PDF document to be filled.

The rest of the key/value pairs will be used to fill in the form within the PDF.

### Filling Multiple Forms
Similar to filling out a single form, but in this case the URI is `/fill_all`.
The POST data in this case should include a `pdfs` key, with a comma-separated
list of URL's for filling out and combining.  The `pdf` key is still "special",
in that it will determine the filename of the output document.  If not
specified `document.pdf` will be used.

    pdfs=http://help.adobe.com/en_US/Acrobat/9.0/Samples/interactiveform_enabled.pdf,http://help.adobe.com/en_US/Acrobat/9.0/Samples/interactiveform_enabled.pdf,http://help.adobe.com/en_US/Acrobat/9.0/Samples/interactiveform_enabled.pdf

This example will fill out the same PDF three times and concatenate them together.

## Inspiration

Much of the inspiration for this project came from the
[pdf-filler project](https://github.com/project-open-data/pdf-filler)
hosted at [labs.data.gov](https://labs.data.gov/pdf-filler/).
