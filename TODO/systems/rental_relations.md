###bicycle#show画面

####current_userが詳細画面の自転車にレンタルを申し込んでいない時
- [x] 「レンタルを申し込む」ボタンが表示される
#####「レンタルを申し込む」ボタンを押下すると
- [x] RentalRelation.countが1増える
- [x] 「この自転車のレンタルを申し込みました。」のメッセージが表示される
- [x] bicycle#show画面にリダイレクトする
- [x] 「レンタル希望を取り消す」ボタンが表示される

####current_userが詳細画面の自転車にレンタルを申し込んでいる時
- [x] レンタル希望を取り消す」ボタンが表示される
####「レンタル希望を取り消す」ボタンを押下すると
- [x] RentalRelation.countが1減る
- [x] 「この自転車のレンタル申し込みををキャンセルしました。」のメッセージが表示される
- [x] bicycle#show画面にリダイレクトする
- [x] 「レンタルを申し込む」ボタンが表示される