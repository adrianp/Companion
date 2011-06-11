(definstances INSTANCES

([main_Class20021] of  Schedule

	(day [main_Class20022])
	(ID "John Brown's Agenda"))

([main_Class20022] of  Day

	(date "15.06.2011")
	(plans [main_Class20075]))

([main_Class20034] of  Preparation

	(duration [main_Class20035])
	(effects [main_Class20050])
	(ID "LaboratoryPreparation")
	(preconditions [main_Class20043]))

([main_Class20035] of  Duration

	(length [main_Class20036]))

([main_Class20036] of  Time+Interval

	(end+time [main_Class20037])
	(start+time [main_Class20038]))

([main_Class20037] of  Time+Point

	(value "1"))

([main_Class20038] of  Time+Point

	(value "0"))

([main_Class20043] of  DescriptionPattern

	(ID "LaboratoryPreparationPreconditions")
	(parameters [main_Class20069])
	(type "position"))

([main_Class20050] of  DescriptionPattern

	(ID "LaboratoryPrepared")
	(parameters [main_Class20051])
	(type "preparation"))

([main_Class20051] of  Other

	(value "didactic laboratory"))

([main_Class20053] of  Preparation

	(duration [main_Class20054])
	(effects [main_Class20060])
	(ID "LecturePreparation")
	(preconditions [main_Class20057]))

([main_Class20054] of  Duration

	(length [main_Class20055]))

([main_Class20055] of  Time+Interval

	(end+time [main_Class20056])
	(start+time [main_Class20038]))

([main_Class20056] of  Time+Point

	(value "2"))

([main_Class20057] of  DescriptionPattern

	(ID "LecturePreparationPreconditions")
	(parameters [main_Class20070])
	(type "position"))

([main_Class20060] of  DescriptionPattern

	(ID "LecturePrepared")
	(parameters [main_Class20061])
	(type "preparation"))

([main_Class20061] of  Other

	(value "didactic laboratory"))

([main_Class20063] of  travelling

	(ID "A-N")
	(preconditions
		[main_Class20064]
		[main_Class20050]
		[main_Class20060]
		[main_Class20067]))

([main_Class20064] of  DescriptionPattern

	(ID "AtUniversity")
	(parameters [main_Class20071])
	(type "position"))

([main_Class20067] of  Time+Point

	(value "14"))

([main_Class20069] of  Place

	(value "laboratory"))

([main_Class20070] of  Place

	(value "library"))

([main_Class20071] of  Place

	(value "university"))

([main_Class20073] of  Profession

	(name "Professor")
	(specificActivities
		[main_Class20034]
		[main_Class20053]))

([main_Class20075] of  Plan

	(initialState [main_Class20076])
	(objective [main_Class20063]))

([main_Class20076] of  travelling

	(effects [main_Class20077])
	(ID "A-0"))

([main_Class20077] of  DescriptionPattern

	(ID "AtHome")
	(parameters [main_Class20078])
	(type "position"))

([main_Class20078] of  Place
	(value "home"))

)
