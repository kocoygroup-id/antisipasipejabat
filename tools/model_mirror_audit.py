#!/usr/bin/env python3
import random, math, sys
POS={'grievance':.14,'trigger':.13,'salience':.10,'online':.08,'coalition':.08,'organization':.07,'economic_stress':.07,'institutional_distrust':.08,'incident_shock':.08,'recent_precedent':.04,'media_attention':.05,'public_support':.05,'regional_relevance':.03}
NEG={'govt_communication':.06,'govt_responsiveness':.08}
SP={'online':.20,'coalition':.15,'salience':.14,'regional_relevance':.18,'public_support':.12,'media_attention':.11,'recent_precedent':.10}
scopes=['lokal','kota','provinsi','multi_provinsi','nasional']
LB={'lokal':0,'kota':1,'provinsi':2,'multi_provinsi':4,'nasional':5}
SB={'lokal':-8,'kota':-3,'provinsi':1,'multi_provinsi':5,'nasional':8}
def clamp(x): return max(0,min(100,x))
def scores(s):
    l=clamp(8+sum(s[k]*w for k,w in POS.items())-sum(s[k]*w for k,w in NEG.items())+LB[s['scope']])
    sp=clamp(sum(s[k]*w for k,w in SP.items())+SB[s['scope']])
    dur=min(100,s['duration_days']*12)
    e=clamp(.94*(s['grievance']*.14+s['incident_shock']*.20+s['intervention_pressure']*.18+s['institutional_distrust']*.11+s['trigger']*.10+dur*.08+(100-s['organizer_control'])*.10+(100-s['govt_responsiveness'])*.09))
    return l,sp,e
rng=random.Random(20260817)
for i in range(25000):
    s={k:rng.uniform(0,100) for k in set(POS)|set(NEG)|set(SP)|{'intervention_pressure','organizer_control'}}
    s['scope']=rng.choice(scopes); s['duration_days']=rng.randint(1,365)
    vals=scores(s)
    if not all(0 <= x <= 100 for x in vals):
        print('FAIL bounds',i,vals);sys.exit(1)
# targeted sanity: all pressure-driving features up and mitigators down must increase likelihood
lo={k:20 for k in set(POS)|set(NEG)|set(SP)|{'intervention_pressure','organizer_control'}}
lo.update(scope='kota',duration_days=1,govt_communication=90,govt_responsiveness=90,organizer_control=90,intervention_pressure=5)
hi={k:85 for k in set(POS)|set(NEG)|set(SP)|{'intervention_pressure','organizer_control'}}
hi.update(scope='nasional',duration_days=10,govt_communication=10,govt_responsiveness=10,organizer_control=40,intervention_pressure=80)
a=scores(lo); b=scores(hi)
if not (b[0]>a[0] and b[1]>a[1] and b[2]>a[2]):
    print('FAIL sanity',a,b);sys.exit(1)
print('MODEL MIRROR AUDIT')
print('random scenarios checked: 25000')
print('low:',tuple(round(x,2) for x in a))
print('high:',tuple(round(x,2) for x in b))
print('RESULT: PASS')
