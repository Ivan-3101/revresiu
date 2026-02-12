delete from ui.rolemenuaccessmap where itenantid= 14 and iroleid=14 and imenuid in (501, 576, 577);

delete from ui.rolemenuaccessmap where itenantid= 14 and iroleid=16 and imenuid in (519, 520, 525, 526, 527, 529, 530, 538, 539, 540, 533, 535,551,552,558,559, 566,567,568,587,588,584,597,598,600,594,596);

update ui.rolemenuaccessmap  set bedit = true where itenantid= 14 and iroleid=16 and imenuid in  (
499,
501,
521,
522,
528,
547,
554,
561,
576
)

delete from ui.rolemenuaccessmap where imenuid=602 and itenantid in (14);