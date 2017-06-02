You need TWO table inputs to explore your data. 1) An OTU counts table and 2) a table of metadata. See below for a description, and download examples [here](https://github.com/mmacklai/example-scripts/tree/master/qiime_pipeline/test_data)

BOTH tables should be **Plain text, UNIX-encoded, tab-separated**

You *can* make your metadata table in Excel, and save as .txt tab-delimited
- If you do this, you may need to open your table in a prgoram like [TextWrangler](http://www.barebones.com/products/textwrangler/) (Mac) or [Atom](https://atom.io) (Mac and Windows) or [NotePad++](https://notepad-plus-plus.org) (Windows)* (see footnote below) to ensure the encoding and whitespaces are correct

### 1) OTU table format

- Columns are sample IDs
- Rows are OTUs or features
- Values are integers (counts)
- Plain text, UNIX-encoded, tab-separated


##### Good practices to follow
- Do *not* use spaces or special characters in your header names. e.g. instead of `Sample #15 Baseline` use `s15_B`
  - "_" and "-" are good to use in place of spaces
- Be as concise, but as informative as possible in your naming. Use short forms and include timepoint information etc. (see example above)

##### Example:
		OTU_ID	s1_t1	s1_t2	s2_t1	s2_t2
		0	34	23	456	469
		1	564	342	54	243
		2	4	56	76	345

Download an example OTU table here:  
https://github.com/mmacklai/example-scripts/tree/master/qiime_pipeline/test_data

The only non-integer column you may have in your counts table, is a last column of taxonomy

QIIME-style OTU tables are OK, but you will have to convert your .biom table to tab-delemited to work in R
`convert_biom.py -i otu_table.biom -o otu_table.txt -b --header_key='taxonomy"`

---------------
#### 2) Metadata table format

In addition to your counts table, you likely want a table of information about your samples. The same priciples apply for formatting as above. Download an example here:  
https://github.com/mmacklai/example-scripts/tree/master/qiime_pipeline/test_data

##### Example:
		Sample_ID	time	study	probio	age	a_dis	a_whiff	a_ph	a_clue	n_status
		s1_t0	0	b_cont	NA	41	n	n	0	ND	n
		s1_t1	1	b_cont	NA	36	n	n	0	ND	n
		s2_t0	0	b_cont	NA	45	n	n	0	ND	n

Note:
- The Sample Ids in your meta must match EXACLTY what is in your OTU table. Any sample that occurs in your OTU table MUST also occur in your metadata table
- Be consistent in your columns: Don't use "yes", "y", and "Y" as these are all different characters.
- Please only use only alphanumeric characters and "\_" and "\-" and space. NO quotes, asterisks, or funny characters of any sort

Some columns you probably want to include in your matadata table
- Sample ID
- Timepoint
- Group _(e.g. treatment group, or control vs disease)_
- Left barcode
- Right barcode
- Date of extraction
- Date of collection
- Qubit value after PCR amplification _(this is ESPECIALLY IMPORANT to evaluate negative controls)_

You want to be able to examine and (hopefully) rule out any technical variation in the structure of your data. It's therefore VERY important to include as much information about your samples as possible, even if you think it may not have an impact (becasue it might!)

---------
###### Footnotes
If you are using Notepad++, you will need to do the following:
````
To view characters: view -> show symbol -> show end of line

Change from windows to unix encoding: settings -> preferences -> new document -> format
````
