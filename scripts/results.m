%%

meanface = mean(Faces);
imshow(reshape(meanface,[64,64]))
saveas(gcf,'Mean Face.png')
title('Mean Face IFAD')

%%

Databasepath = 'out\';
females = {'11 dimple kapadia';'13 hama malini';'14 jai bachan';'15 kajol';'16 krishma kapoor';'17 madhuri dixit';'19 neetu singh';'20 poonam dhillon';'21 rakhi';'22rekha';'28 shilpa shetty';'29 shirmila tagor';'30 sonali bindre';'32 sridevi';'33 susmita sen';'34 sania mirza';'38 rani mukrjee';'39 reena roy';'41 padmani kalapure';'42 Preti zinta';'46 shabana azmi';'47 mosmi chaterji';'48 tanuja';'49 waheeda rehman';'52 asha bhosle';'54 vidya bala';'55 kareena kapoor';'6 amrita singh';'8 ashwaraya rai';'9 bipasha basu'};

femalecount = 0;
for f=1:size(females,1)
    f = strcat(Databasepath,females(f))
    l = ListDirectory(f{1})
    femalecount = femalecount + size(l,1);
    
end
femalecount = femalecount - length(females)

males = {'1 aamir khan';'10 darminder';'12 gobinda';'18 mithun';'2 adnan sami';'23 rishi kapoor';'24 sachin tandolkar';'25 salman khan';'26 saif ali khan';'27 sanjay dutt';'3 ajay devgan';'31 sonu nigam';'35 sunny deol';'36 asrani';'37 johny lever';'4 akshay kumar';'40 shakti kapoor';'43 sunil shetty';'44 presh rawal';'45 neesrudin shah';'5 amitabh bachan';'50 vinod khanna';'51 rajbabar';'53 gurdas maan';'7 anil kapoor'};


malecount = 0;
for f=1:size(males,1)
    f = strcat(Databasepath,males(f))
    l = ListDirectory(f{1})
    malecount = malecount + size(l,1);
end

malecount = malecount - length(males)

%%
y = [malecount; femalecount];
bar(y)
title('Male and female Subject Count in the Database')
set(gca,'XTickLabel',{'Males','Females'})
saveas(gcf,'Male and female Subject Count in the Database.png')


%%

hist(id,length(unique(id)))
title('Frequency of Subjects in the Database')
xlabel('Subject')
ylabel('Count')
saveas(gcf,'Frequency of Subjects in the Database.png');
