#!/bin/sh

# usage: script/test-word.sh [word-to-test] "[test-sentence]"

word=$1
sentence=$2

PROJECT_ROOT=`cat script/project-root.txt`
prep_dir=$PROJECT_ROOT/modality-words/idiosyncratic
word_dir=$PROJECT_ROOT/modality-words/instantiated-templates
tmp_dir=$PROJECT_ROOT/tmp
parser_dir=$PROJECT_ROOT/tools/stanford-parser
tregex_dir=$PROJECT_ROOT/tools/stanford-tregex

# parse the sentence
echo $sentence > $tmp_dir/$word.txt
$parser_dir/lexparser.sh $tmp_dir/$word.txt > $tmp_dir/$word.parsed

# tag the sentence
cd $tregex_dir
./tsurgeon.sh -treeFile $tmp_dir/$word.parsed \
  $prep_dir/relabel-vb-zero.txt $prep_dir/remove-g.txt $prep_dir/remove-n.txt $prep_dir/remove-d.txt $prep_dir/remove-z.txt $prep_dir/remove-p.txt $prep_dir/mark-have-aux.txt $prep_dir/mark-be-aux.txt $prep_dir/mark-get-passive.txt $prep_dir/mark-passive-verbs.txt $prep_dir/md-must-have.txt $prep_dir/negative.txt $prep_dir/negative-never.txt $prep_dir/negative-finite-be.txt $prep_dir/have-to.txt $prep_dir/let-vp.txt $prep_dir/let-s.txt $prep_dir/have-need-of.txt $prep_dir/in-need-of.txt $prep_dir/fall-short.txt $prep_dir/fall-short-jj.txt \
  $word_dir/$word*

# cleanup
rm $tmp_dir/$word*

exit 0
