(defclass %3ACLIPS_TOP_LEVEL_SLOT_CLASS "Fake class to save top-level slot information"
	(is-a USER)
	(role abstract)
	(multislot hobby
		(type INSTANCE)
;+		(allowed-classes)
		(create-accessor read-write))
	(multislot time+slot
		(type INSTANCE)
;+		(allowed-classes Time+Interval)
		(create-accessor read-write))
	(multislot effects
		(type INSTANCE)
;+		(allowed-classes DescriptionPattern)
		(create-accessor read-write))
	(single-slot main_Class20068
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot main_Class13
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot schedule
		(type INSTANCE)
;+		(allowed-classes Schedule)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot initialState
		(type INSTANCE)
;+		(allowed-classes ActivityPattern)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(multislot other+participants
		(type INSTANCE)
;+		(allowed-classes Person)
		(create-accessor read-write))
	(single-slot main_Class20049
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot time
		(type INSTANCE)
;+		(allowed-classes Time+Interval)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot minutes
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot plans
		(type INSTANCE)
;+		(allowed-classes Plan)
		(create-accessor read-write))
	(single-slot length
		(type INSTANCE)
;+		(allowed-classes Time+Interval)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot actions
		(type INSTANCE)
;+		(allowed-classes ActivityPattern)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot date
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot main_Class5
		(type INSTANCE)
;+		(allowed-classes Profession)
		(create-accessor read-write))
	(single-slot ID
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot profession
		(type INSTANCE)
;+		(allowed-classes Profession)
		(create-accessor read-write))
	(single-slot main_Class10005
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot main_Class20032
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot main_Class20030
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot end+time
		(type INSTANCE)
;+		(allowed-classes Time+Point)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot type
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot start+time
		(type INSTANCE)
;+		(allowed-classes Time+Point)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot duration
		(type INSTANCE)
;+		(allowed-classes Duration)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot main_Class10008
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(multislot parameters
		(type INSTANCE)
;+		(allowed-classes DescriptionParameters)
		(create-accessor read-write))
	(single-slot main_Class20026
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot main_Class20027
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(multislot day
		(type INSTANCE)
;+		(allowed-classes Day)
		(create-accessor read-write))
	(multislot preconditions
		(type INSTANCE)
;+		(allowed-classes DescriptionPattern Time+Point)
		(create-accessor read-write))
	(single-slot name_
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot activity
		(type INSTANCE)
;+		(allowed-classes ActivityPattern)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot specificActivities
		(type INSTANCE)
;+		(allowed-classes ActivityPattern)
		(create-accessor read-write))
	(single-slot main_Class20029
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(multislot objective
		(type INSTANCE)
;+		(allowed-classes ActivityPattern)
		(create-accessor read-write))
	(single-slot value
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Person
	(is-a USER)
	(role concrete)
	(single-slot schedule
		(type INSTANCE)
;+		(allowed-classes Schedule)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot profession
		(type INSTANCE)
;+		(allowed-classes Profession)
		(create-accessor read-write))
	(single-slot name_
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Profession
	(is-a USER)
	(role concrete)
	(single-slot name_
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot specificActivities
		(type INSTANCE)
;+		(allowed-classes ActivityPattern)
		(create-accessor read-write)))

(defclass Schedule
	(is-a USER)
	(role concrete)
	(single-slot ID
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot day
		(type INSTANCE)
;+		(allowed-classes Day)
		(create-accessor read-write)))

(defclass ActivityPattern
	(is-a USER)
	(role concrete)
	(single-slot ID
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot other+participants
		(type INSTANCE)
;+		(allowed-classes Person)
		(create-accessor read-write))
	(multislot effects
		(type INSTANCE)
;+		(allowed-classes DescriptionPattern)
		(create-accessor read-write))
	(multislot preconditions
		(type INSTANCE)
;+		(allowed-classes DescriptionPattern Time+Point)
		(create-accessor read-write))
	(single-slot duration
		(type INSTANCE)
;+		(allowed-classes Duration)
;+		(cardinality 0 1)
		(create-accessor read-write)))

(defclass Didactic+Activity
	(is-a ActivityPattern)
	(role concrete))

(defclass Lecture
	(is-a Didactic+Activity)
	(role concrete))

(defclass Laboratory
	(is-a Didactic+Activity)
	(role concrete))

(defclass Preparation
	(is-a Didactic+Activity)
	(role concrete))

(defclass Other+Activities
	(is-a ActivityPattern)
	(role concrete))

(defclass travelling
	(is-a Other+Activities)
	(role concrete))

(defclass Time
	(is-a USER)
	(role concrete))

(defclass Time+Interval
	(is-a Time)
	(role concrete)
	(single-slot start+time
		(type INSTANCE)
;+		(allowed-classes Time+Point)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot end+time
		(type INSTANCE)
;+		(allowed-classes Time+Point)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Day
	(is-a Time)
	(role concrete)
	(multislot plans
		(type INSTANCE)
;+		(allowed-classes Plan)
		(create-accessor read-write))
	(single-slot date
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Duration
	(is-a Time)
	(role concrete)
	(single-slot length
		(type INSTANCE)
;+		(allowed-classes Time+Interval)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Time+Point
	(is-a Time)
	(role concrete)
	(single-slot value
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass DescriptionPattern
	(is-a USER)
	(role concrete)
	(single-slot ID
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot type
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot parameters
		(type INSTANCE)
;+		(allowed-classes DescriptionParameters)
		(create-accessor read-write)))

(defclass Plan
	(is-a USER)
	(role concrete)
	(single-slot initialState
		(type INSTANCE)
;+		(allowed-classes ActivityPattern)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot actions
		(type INSTANCE)
;+		(allowed-classes ActivityPattern)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(multislot objective
		(type INSTANCE)
;+		(allowed-classes ActivityPattern)
		(create-accessor read-write)))

(defclass DescriptionParameters
	(is-a USER)
	(role concrete)
	(single-slot value
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Place
	(is-a DescriptionParameters)
	(role concrete))

(defclass Other
	(is-a DescriptionParameters)
	(role concrete))
