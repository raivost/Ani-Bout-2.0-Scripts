--[AB] Ani-Bout Duel 
--Scripted by Raivost (Ravi)
local s,id=GetID()
function s.initial_effect(c)
    --Influence Counter
    c:EnableCounterPermit(0x891)
    --Essence Counter
    c:EnableCounterPermit(0x892)
    --(0) Activate
    local e0=Effect.CreateEffect(c)
    e0:SetType(EFFECT_TYPE_ACTIVATE)
    e0:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e0)
    --(1) Auto-Activate From Hand Or Deck
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e1:SetCode(EVENT_PREDRAW)
    e1:SetRange(LOCATION_HAND+LOCATION_DECK)
    e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_DUEL)
    e1:SetCondition(s.auto_activate_condition)
    e1:SetOperation(s.auto_activate_operation)
    c:RegisterEffect(e1)
    --(2) Field Protection
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
    e2:SetRange(LOCATION_FZONE)
    e2:SetValue(1)
    c:RegisterEffect(e2)
    local e3=e2:Clone()
    e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
    c:RegisterEffect(e3)
    local e4=e2:Clone()
    e4:SetCode(EFFECT_CANNOT_REMOVE)
    c:RegisterEffect(e4)
    --(3) Immune Hero
    local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_FIELD)
    e5:SetCode(EFFECT_IMMUNE_EFFECT)
    e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e5:SetRange(LOCATION_FZONE)
    e5:SetTargetRange(LOCATION_MZONE,0)
    e5:SetTarget(s.hero_target)
    e5:SetValue(s.hero_immune_value)
    c:RegisterEffect(e5)
    local e6=e5:Clone()
    e6:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
    e6:SetValue(1)
    c:RegisterEffect(e6)
    --(4) Hero Cannot Attack
    local e7=Effect.CreateEffect(c)
    e7:SetType(EFFECT_TYPE_FIELD)
    e7:SetCode(EFFECT_CANNOT_ATTACK)
    e7:SetRange(LOCATION_FZONE)
    e7:SetTargetRange(LOCATION_MZONE,0)
    e7:SetTarget(s.hero_target)
    c:RegisterEffect(e7)
    --(5) Hero Cannot Be Attacked
    local e8=Effect.CreateEffect(c)
    e8:SetType(EFFECT_TYPE_SINGLE)
    e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e8:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
    e8:SetRange(LOCATION_MZONE)
    e8:SetValue(1)
    c:RegisterEffect(e8)
    local e9=Effect.CreateEffect(c)
    e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
    e9:SetRange(LOCATION_FZONE)
    e9:SetTargetRange(LOCATION_MZONE,0)
    e9:SetTarget(s.hero_target)
    e9:SetLabelObject(e8)
    c:RegisterEffect(e9)
    --(6) Hero's DEF = Total influence
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_UPDATE_DEFENSE)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetValue(s.hero_total_influence_value)
	c:RegisterEffect(e10)
    local e11=Effect.CreateEffect(c)
    e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
    e11:SetRange(LOCATION_FZONE)
    e11:SetTargetRange(LOCATION_MZONE,0)
    e11:SetTarget(s.hero_target)
    e11:SetLabelObject(e10)
    c:RegisterEffect(e11)
    --(7) Hero's ATK = Current influence
    local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetCode(EFFECT_UPDATE_ATTACK)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetValue(s.hero_current_influence_value)
	c:RegisterEffect(e12)
    local e13=Effect.CreateEffect(c)
    e13:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
    e13:SetRange(LOCATION_FZONE)
    e13:SetTargetRange(LOCATION_MZONE,0)
    e13:SetTarget(s.hero_target)
    e13:SetLabelObject(e12)
    c:RegisterEffect(e13)
    --(8) Rank Up Hero And Add Influence + Essence Counters
    local e14=Effect.CreateEffect(c)
    e14:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e14:SetTargetRange(1,0)
    e14:SetCode(EVENT_PREDRAW)
    e14:SetRange(LOCATION_FZONE)
    e14:SetCountLimit(1)
    e14:SetCondition(s.add_counter_condition)
    e14:SetOperation(s.add_counter_operation)
    c:RegisterEffect(e14)
    --(9) Reduce Total Influence
    local e15=Effect.CreateEffect(c)
    e15:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e15:SetTargetRange(1,0)
    e15:SetCode(EVENT_PHASE+PHASE_END)
    e15:SetRange(LOCATION_FZONE)
    e15:SetCountLimit(1)
    e15:SetCondition(s.reduce_influence_condition)
    e15:SetOperation(s.reduce_influence_operation)
    c:RegisterEffect(e15)
    --(10) Level Limit
    local e16=Effect.CreateEffect(c)
    e16:SetType(EFFECT_TYPE_FIELD)
    e16:SetRange(LOCATION_FZONE)
    e16:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e16:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e16:SetTargetRange(1,0)
    e16:SetTarget(s.level_limit_target)
    c:RegisterEffect(e16)
    --(11) Cannot Normal Summon/Set Monsters
    local e17=Effect.CreateEffect(c)
    e17:SetType(EFFECT_TYPE_FIELD)
    e17:SetRange(LOCATION_FZONE)
    e17:SetCode(EFFECT_CANNOT_SUMMON)
    e17:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e17:SetTargetRange(1,0)
    c:RegisterEffect(e17)
    local e18=e17:Clone()
    e18:SetCode(EFFECT_CANNOT_MSET)
    c:RegisterEffect(e18)
    --(12) Special Summon From Hand
    local e19=Effect.CreateEffect(c)
    e19:SetType(EFFECT_TYPE_FIELD)
    e19:SetCode(EFFECT_SPSUMMON_PROC)
    e19:SetProperty(EFFECT_FLAG_SPSUM_PARAM)
    e19:SetTargetRange(POS_FACEUP,0)
    e19:SetRange(LOCATION_HAND)
    e19:SetCondition(s.special_summon_condition)
    c:RegisterEffect(e19)
    local e20=Effect.CreateEffect(c)
    e20:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
    e20:SetRange(LOCATION_FZONE)
    e20:SetTargetRange(LOCATION_HAND,0)
    e20:SetTarget(s.special_summon_target)
    e20:SetLabelObject(e19)
    c:RegisterEffect(e20)
    --(13) Disarmed Cannot Attack
    local e21=Effect.CreateEffect(c)
    e21:SetType(EFFECT_TYPE_FIELD)
    e21:SetCode(EFFECT_CANNOT_ATTACK)
    e21:SetRange(LOCATION_FZONE)
    e21:SetTargetRange(LOCATION_MZONE,0)
    e21:SetTarget(s.disarm_target)
    c:RegisterEffect(e21)
    --(14) Anguish Reflect Damage To Controller
    local e22=Effect.CreateEffect(c)
	e22:SetDescription(aux.Stringid(id,0))
	e22:SetCategory(CATEGORY_DESTROY)
	e22:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e22:SetCode(EVENT_DAMAGE_STEP_END)
	e22:SetTarget(s.anguish_effect_target)
	e22:SetOperation(s.anguish_effect_operation)
	c:RegisterEffect(e22)
    local e23=Effect.CreateEffect(c)
    e23:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
    e23:SetRange(LOCATION_FZONE)
    e23:SetTargetRange(LOCATION_MZONE,0)
    e23:SetTarget(s.anguish_target)
    e23:SetLabelObject(e22)
    c:RegisterEffect(e23)
    --(15) Cannot Set Spells
    local e24=Effect.CreateEffect(c)
    e24:SetType(EFFECT_TYPE_FIELD)
    e24:SetCode(EFFECT_CANNOT_SSET)
    e24:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e24:SetRange(LOCATION_FZONE)
    e24:SetTargetRange(1,0)
    e24:SetTarget(aux.TRUE)
    c:RegisterEffect(e24)
    --(16) Activate Spell
    local e25=Effect.CreateEffect(c)
    e25:SetType(EFFECT_TYPE_FIELD)
    e25:SetCode(EFFECT_CANNOT_ACTIVATE)
    e25:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e25:SetRange(LOCATION_FZONE)
    e25:SetTargetRange(1,0)
    e25:SetValue(s.activate_spell_value)
    c:RegisterEffect(e25)
    --(17) Haste Spells
    local e26=Effect.CreateEffect(c)
    e26:SetType(EFFECT_TYPE_FIELD)
    e26:SetCode(EFFECT_ADD_TYPE)
    e26:SetRange(LOCATION_FZONE)
    e26:SetTargetRange(LOCATION_HAND,0)
    e26:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x897))
    e26:SetValue(TYPE_QUICKPLAY)
    c:RegisterEffect(e26)
    local e27=e26:Clone()
    e27:SetCode(EFFECT_BECOME_QUICK)
    c:RegisterEffect(e27)
    --(18) Activate Haste Spells During Both Turns
    local e28=Effect.CreateEffect(c)
    e28:SetType(EFFECT_TYPE_FIELD)
    e28:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
    e28:SetRange(LOCATION_FZONE)
    e28:SetTarget(s.haste_target)
    e28:SetTargetRange(LOCATION_HAND,0)
    c:RegisterEffect(e28)
    --(19) Exhaust Spells
    local e29=Effect.CreateEffect(c)
    e29:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e29:SetCode(EVENT_LEAVE_FIELD_P)
    e29:SetProperty(EFFECT_FLAG_DELAY)
    e29:SetOperation(s.exhaust_operation)
    c:RegisterEffect(e29)
    local e30=Effect.CreateEffect(c)
    e30:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
    e30:SetRange(LOCATION_FZONE)
    e30:SetTargetRange(LOCATION_SZONE,0)
    e30:SetTarget(s.exhaust_target)
    e30:SetLabelObject(e29)
    c:RegisterEffect(e30)
end

s.heroes = {899800000,899800020,899800040}

s.tohka  = {899800001,899800004}
s.madoka = {899800021,899800024}
s.kirito = {899800041,899800044}

 --(1) Auto-Activate From Hand Or Deck
function s.auto_activate_condition(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnCount()==1 and Duel.GetFieldCard(tp,LOCATION_SZONE,5)==nil
end
function s.hero_summon_filter(c,e,tp)
  return c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) 
end
function s.auto_activate_operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c and Duel.GetFieldCard(tp,LOCATION_SZONE,5)==nil and aux.PlayFieldSpell(c,e,tp,eg,ep,ev,re,r,rp) then
    --If Activated From Hand -> Draw 1 Card
        if c:IsPreviousLocation(LOCATION_HAND) then
            Duel.Draw(tp,1,REASON_EFFECT)
        end
    end
    --Generate And Summon Heroes
    if Duel.GetTurnPlayer()==1-tp then
        --Generate Heroes Player1
        local heroes_group1=Group.CreateGroup()
        local hero=nil
        for i=1,#s.heroes do
            hero=Duel.CreateToken(tp,s.heroes[i])
            heroes_group1:AddCard(hero)
        end
        --Generate Heroes Player2
        local heroes_group2=Group.CreateGroup()
        for i=1,#s.heroes do
            hero=Duel.CreateToken(1-tp,s.heroes[i])
            heroes_group2:AddCard(hero)
        end
        --Select Hero Player2
        Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(id,0))
        local tc2=heroes_group2:FilterSelect(1-tp,s.hero_summon_filter,1,1,nil,e,1-tp):GetFirst()
        heroes_group2:DeleteGroup()
        local heroes_group2=Group.CreateGroup()
        local hero_list2=nil
        if tc2:IsCode(899800000) then
            hero_list2=s.tohka
        elseif tc2:IsCode(899800020) then
            hero_list2=s.madoka
        elseif tc2:IsCode(899800040) then
            hero_list2=s.kirito
        end
        for i=1,#hero_list2 do
            hero=Duel.CreateToken(1-tp,hero_list2[i])
            heroes_group2:AddCard(hero)
        end
        Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(id,1))
        tc2=heroes_group2:FilterSelect(1-tp,s.hero_summon_filter,1,1,nil,e,1-tp):GetFirst()
        Duel.SendtoDeck(tc2,nil,0,REASON_RULE)
        heroes_group2:DeleteGroup()
        --Select Hero Player1
        Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,0))
        local tc1=heroes_group1:FilterSelect(tp,s.hero_summon_filter,1,1,nil,e,tp):GetFirst()
        heroes_group1:DeleteGroup()
        local heroes_group1=Group.CreateGroup()
        local hero_list1=nil
        if tc1:IsCode(899800000) then
            hero_list1=s.tohka
        elseif tc1:IsCode(899800020) then
            hero_list1=s.madoka
        elseif tc1:IsCode(899800040) then
            hero_list1=s.kirito
        end
        for i=1,#hero_list1 do
            hero=Duel.CreateToken(tp,hero_list1[i])
            heroes_group1:AddCard(hero)
        end
        Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,1))
        tc1=heroes_group1:FilterSelect(tp,s.hero_summon_filter,1,1,nil,e,tp):GetFirst()
        Duel.SendtoDeck(tc1,nil,0,REASON_RULE)
        heroes_group1:DeleteGroup()
        --Summon Hero
        if tc2 and tc1 then
            --Player2
            Duel.SpecialSummon(tc2,0,1-tp,1-tp,false,true,POS_FACEUP_ATTACK,0x60)
            --Player1
            Duel.SpecialSummon(tc1,0,tp,tp,false,true,POS_FACEUP_ATTACK,0x60)  
        end
    end
    --Set LP
    Duel.SetLP(tp,30)
    --Starting Counter Limit
    local counter_limit=1
    --Add Influence Counter
    c:AddCounter(0x891,counter_limit*2)
    --Add Essence Counter
    c:AddCounter(0x892,counter_limit*2)
    --Mulligan
    if Duel.IsPlayerCanDraw(tp) and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil) then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
        local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,0,63,nil)
        if g:GetCount()>0 then
            Duel.SendtoDeck(g,nil,2,REASON_RULE)
            Duel.ShuffleDeck(tp)
            Duel.Draw(tp,#g,REASON_EFFECT)
        end
    end
end
--(3) Immune Hero
function s.hero_target(e,c)
  return c:GetSequence()>=5
end
function s.hero_immune_value(e,te)
  return te:GetOwnerPlayer()~=e:GetHandlerPlayer() and te:GetOwner()~=e:GetOwner() and not te:GetHandler():IsCode(id)
end
--(6) Hero's DEF = Total influence
function s.field_filter(c)
	return c:IsFaceup() and c:IsCode(899900000)
end
function s.hero_total_influence_value(e,c)
    local tc=Duel.GetMatchingGroup(s.field_filter,e:GetHandler():GetControler(),LOCATION_FZONE,0,nil):GetFirst()
	return tc:GetCounter(0x891)
end
--(7) Hero's ATK = Current influence
function s.current_monsters_filter(c)
	return c:IsFaceup() and c:IsLevelAbove(1)
end
function s.hero_current_influence_value(e,c)
    local g=Duel.GetMatchingGroup(s.current_monsters_filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,nil)
    local total_level=0
    if #g>0 then total_level=g:GetSum(Card.GetLevel) end
	return total_level
end
--(8) Rank Up Hero And Add Influence + Essence Counters
function s.hero_filter(c)
  return c:GetSequence()>=5
end
function s.add_counter_condition(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnCount()>2 and Duel.GetTurnPlayer()==tp
  end
function s.add_counter_operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if not c or not c:IsFaceup() then return end
    --Rank Up Hero And Add Influence Counters
    local tc=Duel.GetMatchingGroup(s.hero_filter,tp,LOCATION_MZONE,0,nil):GetFirst()
    if not tc then return end
    if tc:GetRank()==2 or tc:GetRank()==5 then
        local hero=Duel.CreateToken(tp,tc:GetCode()+1)
        Duel.SendtoDeck(tc,nil,-2,REASON_RULE)
        Duel.SendtoDeck(hero,nil,0,REASON_RULE)
        Duel.SpecialSummon(hero,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP_ATTACK,0x60)
        c:AddCounter(0x891,2)
    elseif tc:GetRank()<6 then
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_RANK)
        e1:SetValue(1)
        e1:SetReset(RESET_EVENT+RESETS_STANDARD)
        tc:RegisterEffect(e1)
        c:AddCounter(0x891,2)
    end
    --Reset Essence
    tc=Duel.GetMatchingGroup(s.hero_filter,tp,LOCATION_MZONE,0,nil):GetFirst()
    local hero_rank        = tc:GetRank()
    local essence_counters = c:GetCounter(0x892)
    if essence_counters < hero_rank*2 then
        add_counters=hero_rank*2 - essence_counters
        c:AddCounter(0x892,add_counters)
    end
end
--(9) Reduce Total Influence
function s.reduce_influence_condition(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetMatchingGroup(s.hero_filter,tp,LOCATION_MZONE,0,nil):GetFirst()
    if not tc then return end
    local hero_rank        = tc:GetRank()
    local influce_counters = c:GetCounter(0x891)
    return influce_counters > hero_rank*2
end
function s.reduce_influence_operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetMatchingGroup(s.hero_filter,tp,LOCATION_MZONE,0,nil):GetFirst()
    if not tc then return end
    local hero_rank        = tc:GetRank()
    local influce_counters = c:GetCounter(0x891)
    local remove_counters  =  influce_counters - hero_rank*2
    tc:RemoveCounter(tp,0x881,remove_counters,REASON_EFFECT)
end
--(10) Level Limit
function s.level_limit_target(e,c,tp,sumtp,sumpos)
    local tc=Duel.GetMatchingGroup(s.hero_filter,tp,LOCATION_MZONE,0,nil):GetFirst()
    if not tc then return end
    local hero_rank          = tc:GetRank()
    local influence_counters = e:GetHandler():GetCounter(0x891)
    local g=Duel.GetMatchingGroup(s.current_monsters_filter,tp,LOCATION_MZONE,0,nil)
    local total_level=influence_counters-g:GetSum(Card.GetLevel)
    return c:GetLevel()>hero_rank or c:GetLevel()>total_level
end
--(12) Special Summon From Hand
function s.special_summon_condition(e,c)
    if c==nil then return true end
    return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function s.special_summon_target(e,c)
    return c:IsType(TYPE_MONSTER)
end
--(13) Disarmed Cannot Attack
function s.disarm_target(e,c)
    return c:IsSetCard(0x886)
end
--(14) Anguish Reflect Damage To Controller
function s.anguish_effect_target(e,tp,eg,ep,ev,re,r,rp,chk)
	local damage=Duel.GetBattleDamage(1-tp)
	if chk==0 then return damage>0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(damage)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,damage)
end
function s.anguish_effect_operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_BATTLE)
end
function s.anguish_target(e,c)
    return c:IsSetCard(0x884)
end
--(16) Activate Spell
function s.activate_spell_value(e,te,tp)
    local tc=Duel.GetMatchingGroup(s.hero_filter,tp,LOCATION_MZONE,0,nil):GetFirst()
    if not tc then return end
    local hero_rank=tc:GetRank()
    --Level 1 Spells
    if hero_rank==1 then
        return te:IsHasType(EFFECT_TYPE_ACTIVATE) and not te:GetHandler():IsSetCard(0x891)
    --Level 1+2 Spells
    elseif hero_rank==2 then
        return te:IsHasType(EFFECT_TYPE_ACTIVATE) and not (te:GetHandler():IsSetCard(0x891) or te:GetHandler():IsSetCard(0x892))
    --Level 1+2+3 Spells
    elseif hero_rank==3 then
        return te:IsHasType(EFFECT_TYPE_ACTIVATE) 
          and not (te:GetHandler():IsSetCard(0x891) or te:GetHandler():IsSetCard(0x892) or te:GetHandler():IsSetCard(0x893))
    --Level 1+2+3+4 Spells
    elseif hero_rank==4 then
        return te:IsHasType(EFFECT_TYPE_ACTIVATE) 
          and not (te:GetHandler():IsSetCard(0x891) or te:GetHandler():IsSetCard(0x892) or te:GetHandler():IsSetCard(0x893) 
          or te:GetHandler():IsSetCard(0x894))
    --Level 1+2+3+4+5 Spells
    elseif hero_rank==5 then
        return te:IsHasType(EFFECT_TYPE_ACTIVATE) 
          and not (te:GetHandler():IsSetCard(0x891) or te:GetHandler():IsSetCard(0x892) or te:GetHandler():IsSetCard(0x893) 
          or te:GetHandler():IsSetCard(0x894) or te:GetHandler():IsSetCard(0x895))
    --Level 1+2+3+4+5+6 Spells
    elseif hero_rank==6 then
        return te:IsHasType(EFFECT_TYPE_ACTIVATE) 
          and not (te:GetHandler():IsSetCard(0x891) or te:GetHandler():IsSetCard(0x892) or te:GetHandler():IsSetCard(0x893) 
          or te:GetHandler():IsSetCard(0x894) or te:GetHandler():IsSetCard(0x895) or te:GetHandler():IsSetCard(0x896)) 
    end
end
--(18) Activate Haste Spells During Both Turns
function s.haste_target(e,c)
    return c:IsType(TYPE_QUICKPLAY)
end
--(19) Exhaust Spells
function s.exhaust_target(e,c)
    return c:IsType(TYPE_SPELL) and c:IsSetCard(0x898)
end
function s.exhaust_operation(e,tp,eg,ep,ev,re,r,rp)
    Duel.SendtoDeck(e:GetHandler(),nil,-2,REASON_RULE)
end