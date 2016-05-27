#### OTU table format

- Columns are sample IDs
- Rows are OTUs or features
- Values are integers (counts)
- Plain text, UNIX-encoded, tab-separated

You *can* make your OTU table in Excel (although this is not recommended), and save as .txt tab-delimited
- If you do this, you may need to open your table in a prgoram like [TextWrangler](http://www.barebones.com/products/textwrangler/) (Mac) or [NotePad++](https://notepad-plus-plus.org) (Windows)*(see footnote below) or [Atom](https://atom.io) (Mac and Windows) to ensure the encoding and whitespaces are correct

##### Good practices to follow
- Do *not* use spaces or special characters in your header names. e.g. instead of `Sample #15 Baseline` use `s15_B`
  - "_" and "-" are good to use in place of spaces
- Be as concise, but as informative as possible in your naming. Use short forms and include timepoint information etc. (see example above)

##### Example:
| OTU_ID | s1_t1 | s1_t2 | s2_t1 | s2_t2 |
|--------|-------|-------|-------|-------|
| 0      | 34    | 23    | 456   | 469   |
| 1      | 564   | 342   | 54    | 243   |
| 2      | 4     | 56    | 76    | 345   |

Download an example OTU table here:  
https://github.com/mmacklai/example-scripts/tree/master/qiime_pipeline/test_data

The only non-integer column you may have in your counts table, is a last column of taxonomy

QIIME-style OTU tables are OK, but you will have to convert your .biom table to tab-delemited to work in R
`convert_biom.py -i otu_table.biom -o otu_table.txt -b --header_key='taxonomy"`

---------------
#### metadata table format

In addition to your counts table, you likely want a table of information about your samples. The same priciples apply for formatting as above. Download an example here:  
https://github.com/mmacklai/example-scripts/tree/master/qiime_pipeline/test_data


---------
###### Footnotes
If you are using Notepad++, you will need to do the following:
````
To view characters: view -> show symbol -> show end of line

Change from windows to unix encoding: settings -> preferences -> new document -> format
````
