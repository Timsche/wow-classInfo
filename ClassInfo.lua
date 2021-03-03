local ciAddon = LibStub("AceAddon-3.0"):NewAddon("ClassInfo", "AceEvent-3.0", "AceConsole-3.0")
l_debug = "|cffff0000Debug:|r "

-- Code that you want to run when the addon is first loaded goes here.
function ciAddon:OnInitialize()
    self.spellLib = LibStub("SpellLib-1.02"):New()
    self.innerHeight = 583
    self.innerWidth = 771
    
    self.currentClass = nil
    self.currentSpec = nil
    self.talentFrames = {}
    self.classFrames = {}
    self.specFrames = {}
    self.pvpFrames = {}    
    
    -- chat command
    self:RegisterChatCommand("classinfo", "OnChatCommand")
    
    -- FrameManagement
    self.activeFrames = {}
    self.classFrames = {}
    
    self.classButtons = {        
        {
            name = "deathknightClassBtn",            
            texture = "Interface\\Addons\\ClassInfo\\media\\btn_class_deathknight",
            className = "DEATHKNIGHT"          
        },
        {
            name = "demonhunterClassBtn",            
            texture = "Interface\\Addons\\ClassInfo\\media\\btn_class_demonhunter",
            className = "DEMONHUNTER"          
        },
        {
            name = "druidClassBtn",            
            texture = "Interface\\Addons\\ClassInfo\\media\\btn_class_druid",
            className = "DRUID"          
        },
        {
            name = "hunterClassBtn",            
            texture = "Interface\\Addons\\ClassInfo\\media\\btn_class_hunter",
            className = "HUNTER"          
        },
        {
            name = "mageClassBtn",        
            texture = "Interface\\Addons\\ClassInfo\\media\\btn_class_mage",
            className = "MAGE"          
        },
        {
            name = "monkClassBtn",            
            texture = "Interface\\Addons\\ClassInfo\\media\\btn_class_monk",
            className = "MONK",                   
        },
        {
            name = "paladinClassBtn",            
            texture = "Interface\\Addons\\ClassInfo\\media\\btn_class_paladin",
            className = "PALADIN"          
        },
        {
            name = "priestClassBtn",            
            texture = "Interface\\Addons\\ClassInfo\\media\\btn_class_priest",
            className = "PRIEST"          
        },
        {
            name = "rogueClassBtn",            
            texture = "Interface\\Addons\\ClassInfo\\media\\btn_class_rogue",
            className = "ROGUE"        
        },
        {
            name = "shamanClassBtn",            
            texture = "Interface\\Addons\\ClassInfo\\media\\btn_class_shaman",
            className = "SHAMAN"          
        },
        {
            name = "warlockClassBtn",            
            texture = "Interface\\Addons\\ClassInfo\\media\\btn_class_warlock",
            className = "WARLOCK"
        },
        {
            name = "warriorClassBtn",
            texture = "Interface\\Addons\\ClassInfo\\media\\btn_class_warrior",
            className = "WARRIOR"        
        },                      
    }

    self.specButtons = {
        DEATHKNIGHT = {
            {
                name = "deathknightBloodBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_deathknight_blood",
                specName = "BLOOD"
            },
            {
                name = "deathknightFrostBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_deathknight_frost",
                specName = "FROST"
            },
            {
                name = "deathknightUnholyBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_deathknight_unholy",
                specName = "UNHOLY"
            }
        },
        DEMONHUNTER = {
            {
                name = "demonhunterHavocBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_demonhunter_havoc",
                specName = "HAVOC"
            },
            {
                name = "demonhunterVengeanceBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_demonhunter_vengeance",
                specName = "VENGEANCE"
            }
        },
        DRUID = {
            {
                name = "druidBalanceBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_druid_balance",
                specName = "BALANCE"
            },
            {
                name = "druidFeralBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_druid_feral",
                specName = "FERAL"
            },
            {
                name = "druidGuardianBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_druid_guardian",
                specName = "GUARDIAN"
            },
            {
                name = "druidRestorationBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_druid_restoration",
                specName = "RESTORATION"
            }
        },
        HUNTER = {
            {
                name = "hunterBeastmasteryBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_hunter_beastmastery",
                specName = "BEASTMASTERY"
            },
            {
                name = "hunterMarksmanshipBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_hunter_marksmanship",
                specName = "MARKSMANSHIP"
            },
            {
                name = "hunterSurvivalBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_hunter_survival",
                specName = "SURVIVAL"
            }
        },
        MAGE = {
            {
                name = "mageArcaneBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_mage_arcane",
                specName = "ARCANE"
            },
            {
                name = "magefireBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_mage_fire",
                specName = "FIRE"
            },
            {
                name = "mageFrostBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_mage_frost",
                specName = "FROST"
            }
        },
        MONK = {
            {
                name = "monkBrewmasterBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_monk_brewmaster",
                specName = "BREWMASTER"
            },
            {
                name = "monkMistweaverBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_monk_mistweaver",
                specName = "MISTWEAVER"
            },
            {
                name = "monkWindwalkerBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_monk_windwalker",
                specName = "WINDWALKER"
            }
        },
        PALADIN = {
            {
                name = "paladinHolyBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_paladin_holy",
                specName = "HOLY"
            },
            {
                name = "paladinProtectionBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_paladin_protection",
                specName = "PROTECTION"
            },
            {
                name = "paladinRetributionBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_paladin_retribution",
                specName = "RETRIBUTION"
            }
        },        
        PRIEST = {            
            {
                name = "priestDisciplineBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_priest_discipline",
                specName = "DISCIPLINE"
            },
            {
                name = "priestHolyBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_priest_holy",
                specName = "HOLY"
            },
            {
                name = "priestShadowBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_priest_shadow",
                specName = "SHADOW"
            }
        },
        ROGUE = {            
            {
                name = "rogueAssassinationBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_rogue_assassination",
                specName = "ASSASSINATION"
            },
            {
                name = "rogueOutlawBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_rogue_outlaw",
                specName = "OUTLAW"
            },
            {
                name = "rogueSubtletyBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_rogue_subtlety",
                specName = "SUBTLETY"
            }
        },
        SHAMAN = {            
            {
                name = "shamanElementalBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_shaman_elemental",
                specName = "ELEMENTAL"
            },
            {
                name = "shamanEnhancementBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_shaman_enhancement",
                specName = "ENHANCEMENT"
            },
            {
                name = "shamanRestorationBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_shaman_restoration",
                specName = "RESTORATION"
            }
        },
        WARLOCK = {            
            {
                name = "warlockAfflictionBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_warlock_affliction",
                specName = "AFFLICTION"
            },
            {
                name = "warlockDemonologyBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_warlock_demonology",
                specName = "DEMONOLOGY"
            },
            {
                name = "warlockDestructionBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_warlock_destruction",
                specName = "DESTRUCTION"
            }
        },
        WARRIOR = {            
            {
                name = "warriorArmsBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_warrior_arms",
                specName = "ARMS"
            },
            {
                name = "warriorFuryBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_warrior_fury",
                specName = "FURY"
            },
            {
                name = "warriorProtectionBtn",
                texture = "Interface\\Addons\\ClassInfo\\media\\btn_spec_warrior_protection",
                specName = "PROTECTION"
            }
        },    
    }
end

-- Called when the addon is enabled
function ciAddon:OnEnable()
end

-- Called when the addon is disabled
function ciAddon:OnDisable()
end

-- Open Dialog
function ciAddon:OnChatCommand(params)
    if(self.mainFrame == nil) then
        -- Main Frame with Background
        self.mainFrame = CreateFrame("Frame", "mainFrame", UIParent)
        self.mainFrame:SetPoint("CENTER", UIParent, 0, 120)        
        self.mainFrame:SetSize(843, 653)
        self.mainFrame.bgTexture = self.mainFrame:CreateTexture(nil, "BACKGROUND")
        self.mainFrame.bgTexture:SetTexture("Interface/Addons/ClassInfo/media/main_bg")
        self.mainFrame.bgTexture:SetAllPoints(self.mainFrame)
        self.mainFrame.bgTexture:SetTexCoord(0, 843/1024, 0, 653/1024)  
        self.mainFrame:EnableMouse(true)
        self.mainFrame:SetMovable(true)
        self.mainFrame:SetFrameStrata("Dialog")
        self.mainFrame:RegisterForDrag("LeftButton")
        self.mainFrame:SetScript("OnDragStart", self.mainFrame.StartMoving)
        self.mainFrame:SetScript("OnDragStop", self.mainFrame.StopMovingOrSizing)
                
        -- tabItems        
        self.tabbings = CreateFrame("Frame", "tabbings", self.mainFrame)
        self.tabbings:SetSize(545, 30)
        self.tabbings:SetPoint("BOTTOMLEFT", self.mainFrame, 12, -30)
        
        self.tabbings['selection'] = CreateFrame("Button", "selectionTabItem", self.tabbings, "SecureHandlerClickTemplate")
        self.tabbings['selection']:SetSize(128, 30)
        self.tabbings['selection']:SetPoint("LEFT", self.tabbings, 0, 0)
        self.tabbings['selection']:SetNormalTexture("Interface\\Addons\\ClassInfo\\media\\tabbing_bg_selected")
        self.tabbings['selection']:GetNormalTexture():SetTexCoord(0, 1, 0, 30/32)
        self.tabbings['selection']:SetHighlightTexture("Interface\\Addons\\ClassInfo\\media\\tabbing_bg_hover")
        self.tabbings['selection']:GetHighlightTexture():SetTexCoord(0, 1, 0, 30/32)                    
        self.tabbings['selection'].text = self.tabbings['selection']:CreateFontString(nil, "OVERLAY")
        self.tabbings['selection'].text:SetFont("Fonts\\2002.TTF", 14)
        self.tabbings['selection'].text:SetTextColor(1, 1, 0)
        self.tabbings['selection'].text:SetShadowColor(0, 0, 0, 0.75)        
        self.tabbings['selection'].text:SetShadowOffset(1, -1)
        self.tabbings['selection'].text:SetText("Selection")
        self.tabbings['selection'].text:SetPoint("CENTER", self.tabbings['selection'], 0, 3)  
        self.tabbings['selection']:RegisterForClicks("LeftButtonUp")
        self.tabbings['selection']:SetScript("OnClick", function(self)
            ciAddon:SetTabbing('selection')
            ciAddon:HideAllTabs()
            ciAddon.startTab:Show()
        end)  
                
        self.tabbings['class'] = CreateFrame("Button", "classTabItem", self.tabbings, "SecureHandlerClickTemplate")
        self.tabbings['class']:SetSize(128, 30)
        self.tabbings['class']:SetPoint("LEFT", self.tabbings, 135, 0)
        self.tabbings['class']:SetNormalTexture("Interface\\Addons\\ClassInfo\\media\\tabbing_bg")
        self.tabbings['class']:GetNormalTexture():SetTexCoord(0, 1, 0, 30/32)
        self.tabbings['class']:SetHighlightTexture("Interface\\Addons\\ClassInfo\\media\\tabbing_bg_hover")
        self.tabbings['class']:GetHighlightTexture():SetTexCoord(0, 1, 0, 30/32)                    
        self.tabbings['class'].text = self.tabbings['class']:CreateFontString(nil, "OVERLAY")
        self.tabbings['class'].text:SetFont("Fonts\\2002.TTF", 14)
        self.tabbings['class'].text:SetTextColor(0.5, 0.5, 0.5)
        self.tabbings['class'].text:SetShadowColor(0, 0, 0, 0.75)        
        self.tabbings['class'].text:SetShadowOffset(1, -1)
        self.tabbings['class'].text:SetText("Spells (Class)")
        self.tabbings['class'].text:SetPoint("CENTER", self.tabbings['class'], 0, 3)
        self.tabbings['class']:RegisterForClicks("LeftButtonUp")
        self.tabbings['class']:SetScript("OnClick", function(self)
            ciAddon:SetTabbing('class')
            ciAddon:HideAllTabs()
            ciAddon:ShowClassTab()
        end)
        
        self.tabbings['spec'] = CreateFrame("Button", "specTabItem", self.tabbings, "SecureHandlerClickTemplate")
        self.tabbings['spec']:SetSize(128, 30)
        self.tabbings['spec']:SetPoint("LEFT", self.tabbings, 270, 0)
        self.tabbings['spec']:SetNormalTexture("Interface\\Addons\\ClassInfo\\media\\tabbing_bg")
        self.tabbings['spec']:GetNormalTexture():SetTexCoord(0, 1, 0, 30/32)
        self.tabbings['spec']:SetHighlightTexture("Interface\\Addons\\ClassInfo\\media\\tabbing_bg_hover")
        self.tabbings['spec']:GetHighlightTexture():SetTexCoord(0, 1, 0, 30/32)                    
        self.tabbings['spec'].text = self.tabbings['spec']:CreateFontString(nil, "OVERLAY")
        self.tabbings['spec'].text:SetFont("Fonts\\2002.TTF", 14)
        self.tabbings['spec'].text:SetTextColor(0.5, 0.5, 0.5)
        self.tabbings['spec'].text:SetShadowColor(0, 0, 0, 0.75)        
        self.tabbings['spec'].text:SetShadowOffset(1, -1)
        self.tabbings['spec'].text:SetText("Spells (Spec)")
        self.tabbings['spec'].text:SetPoint("CENTER", self.tabbings['spec'], 0, 3)
        self.tabbings['spec']:RegisterForClicks("LeftButtonUp")
        self.tabbings['spec']:SetScript("OnClick", function(self)
            ciAddon:SetTabbing('spec')
            ciAddon:HideAllTabs()
            ciAddon:ShowSpecTab()
        end)  
                 
        self.tabbings['talents'] = CreateFrame("Button", "talentsTabItem", self.tabbings, "SecureHandlerClickTemplate")
        self.tabbings['talents']:SetSize(128, 30)
        self.tabbings['talents']:SetPoint("LEFT", self.tabbings, 405, 0)
        self.tabbings['talents']:SetNormalTexture("Interface\\Addons\\ClassInfo\\media\\tabbing_bg")
        self.tabbings['talents']:GetNormalTexture():SetTexCoord(0, 1, 0, 30/32)
        self.tabbings['talents']:SetHighlightTexture("Interface\\Addons\\ClassInfo\\media\\tabbing_bg_hover")        
        self.tabbings['talents']:GetHighlightTexture():SetTexCoord(0, 1, 0, 30/32)                    
        self.tabbings['talents'].text = self.tabbings['talents']:CreateFontString(nil, "OVERLAY")
        self.tabbings['talents'].text:SetFont("Fonts\\2002.TTF", 14)
        self.tabbings['talents'].text:SetTextColor(0.5, 0.5, 0.5)
        self.tabbings['talents'].text:SetShadowColor(0, 0, 0, 0.75)        
        self.tabbings['talents'].text:SetShadowOffset(1, -1)
        self.tabbings['talents'].text:SetText("Talents")
        self.tabbings['talents'].text:SetPoint("CENTER", self.tabbings['talents'], 0, 3)
        self.tabbings['talents']:RegisterForClicks("LeftButtonUp")
        self.tabbings['talents']:SetScript("OnClick", function(self)
            ciAddon:SetTabbing('talents')
            ciAddon:HideAllTabs()
            ciAddon:ShowTalentsTab()
        end) 
        
        self.tabbings['pvp'] = CreateFrame("Button", "pvpTabItem", self.tabbings, "SecureHandlerClickTemplate")
        self.tabbings['pvp']:SetSize(128, 30)
        self.tabbings['pvp']:SetPoint("LEFT", self.tabbings, 540, 0)
        self.tabbings['pvp']:SetNormalTexture("Interface\\Addons\\ClassInfo\\media\\tabbing_bg")
        self.tabbings['pvp']:GetNormalTexture():SetTexCoord(0, 1, 0, 30/32) 
        self.tabbings['pvp']:SetHighlightTexture("Interface\\Addons\\ClassInfo\\media\\tabbing_bg_hover")
        self.tabbings['pvp']:GetHighlightTexture():SetTexCoord(0, 1, 0, 30/32)                    
        self.tabbings['pvp'].text = self.tabbings['pvp']:CreateFontString(nil, "OVERLAY")
        self.tabbings['pvp'].text:SetFont("Fonts\\2002.TTF", 14)
        self.tabbings['pvp'].text:SetTextColor(0.5, 0.5, 0.5)
        self.tabbings['pvp'].text:SetShadowColor(0, 0, 0, 0.75)        
        self.tabbings['pvp'].text:SetShadowOffset(1, -1)
        self.tabbings['pvp'].text:SetText("PVP-Talents")
        self.tabbings['pvp'].text:SetPoint("CENTER", self.tabbings['pvp'], 0, 3)
        self.tabbings['pvp']:RegisterForClicks("LeftButtonUp")
        self.tabbings['pvp']:SetScript("OnClick", function(self)
            ciAddon:SetTabbing('pvp')
            ciAddon:HideAllTabs()
            ciAddon:ShowPvpTab()
        end)
        
        self.tabbings:Hide();            
        
        -- classTab (Spells)
        self.classTab = CreateFrame("ScrollFrame", "classTab", self.mainFrame, "UIPanelScrollFrameTemplate")
        self.classTab:SetSize(self.innerWidth, self.innerHeight)
        self.classTab:SetPoint("CENTER")
        self.classTab.inner = CreateFrame("Frame", "classTabInner", self.classTab)
        self.classTab.inner:SetAllPoints(self.classTab)
        self.classTab:SetScrollChild(self.classTab.inner)
        self.classTab.inner:SetSize(self.innerWidth, self.innerHeight) 
       
        -- specTab (Spells)
        self.specTab = CreateFrame("ScrollFrame", "specTab", self.mainFrame, "UIPanelScrollFrameTemplate")
        self.specTab:SetSize(self.innerWidth, self.innerHeight)
        self.specTab:SetPoint("CENTER")        
        self.specTab.inner = CreateFrame("Frame", "specTabInner", self.specTab)
        self.specTab.inner:SetAllPoints(self.specTab)
        self.specTab:SetScrollChild(self.specTab.inner)
        self.specTab.inner:SetSize(self.innerWidth, self.innerHeight)                        
       
        -- talentsTab / include covenant
        self.talentsTab = CreateFrame("Frame", "talentsTab", self.mainFrame)
        self.talentsTab:SetSize(self.innerWidth, self.innerHeight)
        self.talentsTab:SetPoint("CENTER")
        
        -- pvpTab
        self.pvpTab = CreateFrame("Frame", "pvpTab", self.mainFrame)
        self.pvpTab:SetSize(self.innerWidth, self.innerHeight)
        self.pvpTab:SetPoint("CENTER")
        
        -- startTab
        self.startTab = CreateFrame("Frame", "startTab", self.mainFrame)
        self.startTab:SetSize(self.innerWidth, self.innerHeight)
        self.startTab:SetPoint("CENTER")
        self.startTab.classText = self.startTab:CreateFontString(nil, "OVERLAY")
        self.startTab.classText:SetFont("Fonts\\2002.TTF", 34)
        self.startTab.classText:SetTextColor(0.78, 0, 0)
        self.startTab.classText:SetShadowColor(0, 0, 0, 0.75)
        self.startTab.classText:SetShadowOffset(1, -1)
        self.startTab.classText:SetText("select a class")
        self.startTab.classText:SetPoint("CENTER", self.startTab, 0, 200)        
        self.startTab.specText = self.startTab:CreateFontString(nil, "OVERLAY")
        self.startTab.specText:SetFont("Fonts\\2002.TTF", 34)
        self.startTab.specText:SetTextColor(0.78, 0, 0)
        self.startTab.specText:SetShadowColor(0, 0, 0, 0.75)        
        self.startTab.specText:SetShadowOffset(1, -1)
        self.startTab.specText:SetText("select a specialization")
        self.startTab.specText:SetPoint("CENTER", self.startTab, 0, -110)
        self.startTab.specText:Hide()
        
        -- startTab => class buttons
        self.startTab.panels = {}
        for i,btnData in pairs(self.classButtons) do            
            self.startTab[btnData['name']] = CreateFrame("Button", btnData['name'], self.startTab, "SecureHandlerClickTemplate")
            self.startTab[btnData['name']]:SetSize(64, 64)
            self.startTab[btnData['name']]:RegisterForClicks("LeftButtonUp")
            if (i < 7) then                        
                self.startTab[btnData['name']]:SetPoint("left", self.startTab, 50 + (120 * (i - 1)), 130)
            else
                self.startTab[btnData['name']]:SetPoint("left", self.startTab, 50 + (120 * (i - 7)), 30)                        
            end                                    
            self.startTab[btnData['name']]:SetNormalTexture(btnData['texture'])
            
            -- startTab => spec buttons                                                
            self.startTab.panels[btnData['className']] = CreateFrame("Frame", btnData['className'] .. "Panel", self.startTab)                                 
            local btnCount = #self.specButtons[btnData['className']]
            self.startTab.panels[btnData['className']]:SetWidth(btnCount * 64 + (50 * (btnCount - 1)))
            self.startTab.panels[btnData['className']]:SetHeight(64)
            self.startTab.panels[btnData['className']]:SetPoint("CENTER", self.startTab, 0, -180)                
            for j,specBtn in pairs (self.specButtons[btnData['className']]) do
                self.startTab.panels[btnData['className']][specBtn['name']] = CreateFrame("Button", specBtn['name'], self.startTab.panels[btnData['className']], "SecureHandlerClickTemplate")
                self.startTab.panels[btnData['className']][specBtn['name']]:SetSize(64, 64)                                        
                self.startTab.panels[btnData['className']][specBtn['name']]:SetPoint("LEFT", self.startTab.panels[btnData['className']], (j - 1) * (64 + 50), 0)
                self.startTab.panels[btnData['className']][specBtn['name']]:SetNormalTexture(specBtn['texture'])
                self.startTab.panels[btnData['className']][specBtn['name']]:RegisterForClicks("LeftButtonUp")                    
                -- select spec
                self.startTab.panels[btnData['className']][specBtn['name']]:SetScript("OnClick", function(self)                        
                    if ciAddon.currentSpec ~= specBtn['specName'] then 
                        for t,btnX in pairs(ciAddon.specButtons[btnData['className']]) do                            
                            ciAddon.startTab.panels[btnData['className']][btnX['name']]:SetNormalTexture(btnX['texture'])                                
                        end
                        self:SetNormalTexture(specBtn['texture'] .. "_selected")                    
                        ciAddon.currentClass = btnData['className']
                        ciAddon.currentSpec = specBtn['specName']
                        ciAddon:SetTabs(btnData['className'], specBtn['specName'])
                        ciAddon:ShowTabbing()                        
                    end
                end)                                        
                self.startTab.panels[btnData['className']]:Hide()                        
            end                                                             
            
            -- select class
            self.startTab[btnData['name']]:RegisterForClicks("LeftButtonUp")
            self.startTab[btnData['name']]:SetScript("OnClick", function(self)
                if ciAddon.currentClass ~= btnData['className'] then 
                    for j,btnX in pairs(ciAddon.classButtons) do
                        ciAddon.startTab[btnX['name']]:SetNormalTexture(btnX['texture'])
                        ciAddon.startTab.panels[btnX['className']]:Hide()
                        for t,btnY in pairs(ciAddon.specButtons[btnX['className']]) do                            
                            ciAddon.startTab.panels[btnX['className']][btnY['name']]:SetNormalTexture(btnY['texture'])                                
                        end                   
                    end
                    self:SetNormalTexture(btnData['texture'] .. "_selected")
                    ciAddon.tabbings:Hide();
                    ciAddon.startTab.specText:Show()
                    ciAddon.startTab.panels[btnData['className']]:Show()
                    ciAddon.currentClass = btnData['className']
                    ciAddon.currentSpec = nil
                end                    
            end)    
        end
        
        --overlays
        -- frame corner ornaments
        self.overlays = CreateFrame("Frame", "overlaysFrame", self.mainFrame)
        self.overlays:SetAllPoints(self.mainFrame)
        self.overlays:SetFrameLevel(self.startTab:GetFrameLevel() + 10)
        self.overlays.corners = {}
        local corners = { "TOPLEFT", "TOPRIGHT", "BOTTOMRIGHT", "BOTTOMLEFT" }
        for i=1,4 do
            self.overlays.corners[i] = self.overlays:CreateTexture(nil,"OVERLAY")
            self.overlays.corners[i]:SetTexture("Interface/Addons/ClassInfo/media/frame_corner")
            self.overlays.corners[i]:SetRotation(math.rad(-90 * (i - 1)))
            self.overlays.corners[i]:SetPoint(corners[i], self.mainFrame)
                        
        end         
        -- close button
        self.overlays.closeBtn = CreateFrame("Button", "closeMain", self.overlays, "SecureHandlerClickTemplate")
        self.overlays.closeBtn:SetSize(24, 24)
        self.overlays.closeBtn:RegisterForClicks("LeftButtonUp")
        self.overlays.closeBtn:SetNormalTexture("Interface\\Addons\\ClassInfo\\media\\btn_close")
        self.overlays.closeBtn:SetPushedTexture("Interface\\Addons\\ClassInfo\\media\\btn_close_pushed")
        self.overlays.closeBtn:SetPoint("TOPRIGHT", self.overlays, 6, 6)
        self.overlays.closeBtn:GetNormalTexture():SetTexCoord(4/32, 28/32, 4/32, 28/32)
        self.overlays.closeBtn:GetPushedTexture():SetTexCoord(4/32, 28/32, 4/32, 28/32)        
        self.overlays.closeBtn:SetScript("OnClick", function(self)
            ciAddon.mainFrame:Hide()
        end)                                                 
    end
    
    self.mainFrame:Show()   
end

-- hides all tabs
function ciAddon:HideAllTabs()
    self.startTab:Hide()
    self.classTab:Hide()
    self.specTab:Hide()
    self.talentsTab:Hide()
    self.pvpTab:Hide()
end

-- sets all tabs to the selected class and spec
function ciAddon:SetTabs(_class, _spec)    
    self:SetClassTab(_class, _spec)
    self:SetSpecTab(_class, _spec)
    self:SetTalentsTab(_class, _spec)
    self:SetPvpTalentsTab(_class, _spec)    
    self:HideAllTabs()
    self.startTab:Show()
end

-- show tabbings
function ciAddon:ShowTabbing()
    self.tabbings:Show()
end

function ciAddon:SetClassTab(_class, _spec)
    local classSpells = self.spellLib:GetClassSpecSpells(_class, _spec, true, false)
    local counter = 1
    local offsetTop = -10
    
    if self.classTab.inner[_class] == nil then
        self.classTab.inner[_class] = {}
        
        -- display basic class spell
        self.classTab.inner[_class] = CreateFrame("Frame", _class .. "basicSpells", self.classTab.inner)
        self.classTab.inner[_class]:SetPoint("TOPLEFT", 0, offsetTop, self.classTab.inner)       
        for i, spelldata in pairs(classSpells['BASIC']) do            
            local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(spelldata.id)                
            if self.classTab.inner[_class][counter] == nil then
                self.classTab.inner[_class][counter] = CreateFrame("Frame", _class .. "basicSpells" .. counter, self.classTab.inner[_class])
                self.classTab.inner[_class][counter]:SetSize(220, 40)                                
            end
            if self.classTab.inner[_class][counter]['icon'] == nil then
                self.classTab.inner[_class][counter]['icon'] = CreateFrame('Button', _class .. "basicSpells" .. counter .. "Icon", self.classTab.inner[_class][counter], "SecureActionButtonTemplate")
            end        
            self.classTab.inner[_class][counter]['icon']:SetSize(36, 36)
            self.classTab.inner[_class][counter]['icon']:SetNormalTexture(icon)
            self.classTab.inner[_class][counter]['icon']:SetPoint("LEFT")
                                
            if self.classTab.inner[_class][counter]['name'] == nil then
                self.classTab.inner[_class][counter]['name'] = self.classTab.inner[_class][counter]:CreateFontString(nil, "OVERLAY")
            end                        
            self.classTab.inner[_class][counter]['name']:SetFont("Fonts\\2002.TTF", 12)
            self.classTab.inner[_class][counter]['name']:SetTextColor(1, 0.82, 0)
            self.classTab.inner[_class][counter]['name']:SetShadowColor(0, 0, 0, 0.75)
            self.classTab.inner[_class][counter]['name']:SetShadowOffset(1, -1)
            self.classTab.inner[_class][counter]['name']:SetText(spelldata.name)
            self.classTab.inner[_class][counter]['name']:SetPoint("TOPLEFT", 44, -8)
            
            self.classTab.inner[_class][counter].bg = self.classTab.inner[_class][counter]:CreateTexture(nil, "BACKGROUND")
            self.classTab.inner[_class][counter].bg:SetSize(182, 34)
            self.classTab.inner[_class][counter].bg:SetTexture("Interface\\Addons\\ClassInfo\\media\\spell_bg")
            self.classTab.inner[_class][counter].bg:SetTexCoord(0, 182/256, 0, 34/64)
            self.classTab.inner[_class][counter].bg:SetPoint("LEFT", 38, 0)
            
            self.classTab.inner[_class][counter].overlays = CreateFrame("Frame", nil, self.classTab.inner[_class][counter])
            self.classTab.inner[_class][counter].overlays:SetAllPoints(self.classTab.inner[_class][counter])  
            self.classTab.inner[_class][counter].overlays['border'] = self.classTab.inner[_class][counter].overlays:CreateTexture(nil, "OVERLAY")
            self.classTab.inner[_class][counter].overlays['border']:SetSize(38, 38)
            self.classTab.inner[_class][counter].overlays['border']:SetTexture("Interface\\Addons\\ClassInfo\\media\\btn_overlay")
            self.classTab.inner[_class][counter].overlays['border']:SetTexCoord(13/64, 51/64, 13/64, 51/64)
            self.classTab.inner[_class][counter].overlays['border']:SetPoint("LEFT")
        
            local subtext = ""
            if spelldata.passive == 1 then
                subtext = "Passive"
            elseif spelldata.rank > 1 then
                subtext = "Rank " .. spelldata.rank
            end
            if subtext ~= "" then
                if self.classTab.inner[_class][counter]['subtext'] == nil then
                    self.classTab.inner[_class][counter]['subtext'] = self.classTab.inner[_class][counter]:CreateFontString(nil, "OVERLAY")
                end
                self.classTab.inner[_class][counter]['subtext']:SetFont("Fonts\\2002.TTF", 10)
                self.classTab.inner[_class][counter]['subtext']:SetTextColor(0, 0, 0)
                self.classTab.inner[_class][counter]['subtext']:SetText(subtext)
                self.classTab.inner[_class][counter]['subtext']:SetPoint("TOPLEFT", 44, -22)                
            end
    
            if counter % 3 == 1 then
                if counter == 1 then                                                          
                    self.classTab.inner[_class][counter]:SetPoint("TOPLEFT", 20, -10)                    
                else
                    self.classTab.inner[_class][counter]:SetPoint("TOPLEFT", 20, -10 -(22 * (counter - 1)))
                end
            elseif counter % 3 == 2 then
                if counter == 2 then
                    self.classTab.inner[_class][counter]:SetPoint("TOPLEFT", 20 + 220 + 30, -10)
                else
                    self.classTab.inner[_class][counter]:SetPoint("TOPLEFT", 20 + 220 + 30, -10 -(22 * (counter - 2)))
                end
            else
                if counter == 3 then
                    self.classTab.inner[_class][counter]:SetPoint("TOPLEFT", 20 + 220 + 30 + 220 + 30, -10)
                else
                    self.classTab.inner[_class][counter]:SetPoint("TOPLEFT", 20 + 220 + 30 + 220 + 30, -10 -(22 * (counter - 3)))
                end
            end
            -- mouse event tooltip
            self.classTab.inner[_class][counter]['icon']:SetScript("OnEnter", function(self)                                                
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")                       
                GameTooltip:ClearLines()
                GameTooltip:SetHyperlink(GetSpellLink(spelldata.id))       
            end)
            self.classTab.inner[_class][counter]['icon']:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
            
            counter = counter + 1
        end
        if (counter - 1) % 3 == 0 then
            self.classTab.inner[_class]['height'] = ((counter - 1) / 3) * 62 + 32
            self.classTab.inner:SetSize(self.innerWidth, self.classTab.inner[_class]['height'])
            self.classTab.inner[_class]:SetSize(self.innerWidth, self.classTab.inner[_class]['height'])
        else
            local count = (counter - 1) / 3
            count = math.ceil(count)
            self.classTab.inner[_class]['height'] = count * 62 + 32            
            self.classTab.inner:SetSize(self.innerWidth, self.classTab.inner[_class]['height'])
            self.classTab.inner[_class]:SetSize(self.innerWidth, self.classTab.inner[_class]['height'])
        end        
        tinsert(self.classFrames, self.classTab.inner[_class])
    end            
end

function ciAddon:SetSpecTab(_class, _spec)
    local classSpells = self.spellLib:GetClassSpecSpells(_class, _spec, true, false)
    local counter = 1
    local offsetTop = -10
    
    if self.specTab.inner[_class] == nil then
        self.specTab.inner[_class] = {}             
    end
    if self.specTab.inner[_class][_spec] == nil then
        self.specTab.inner[_class][_spec] = CreateFrame("Frame", _class .. "basicSpells", self.specTab.inner)
        self.specTab.inner[_class][_spec]:SetPoint("TOPLEFT", 0, offsetTop, self.specTab.inner) 
               
        for i, spelldata in pairs(classSpells[_spec]) do            
            local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(spelldata.id)                
            if self.specTab.inner[_class][_spec][counter] == nil then
                self.specTab.inner[_class][_spec][counter] = CreateFrame("Frame", _class .. "basicSpells" .. counter, self.specTab.inner[_class][_spec])
                self.specTab.inner[_class][_spec][counter]:SetSize(220, 40)                                
            end
            if self.specTab.inner[_class][_spec][counter]['icon'] == nil then
                self.specTab.inner[_class][_spec][counter]['icon'] = CreateFrame('Button', _class .. "basicSpells" .. counter .. "Icon", self.specTab.inner[_class][_spec][counter], "SecureActionButtonTemplate")
            end        
            self.specTab.inner[_class][_spec][counter]['icon']:SetSize(36, 36)
            self.specTab.inner[_class][_spec][counter]['icon']:SetNormalTexture(icon)
            self.specTab.inner[_class][_spec][counter]['icon']:SetPoint("LEFT")
                                
            if self.specTab.inner[_class][_spec][counter]['name'] == nil then
                self.specTab.inner[_class][_spec][counter]['name'] = self.specTab.inner[_class][_spec][counter]:CreateFontString(nil, "OVERLAY")
            end                        
            self.specTab.inner[_class][_spec][counter]['name']:SetFont("Fonts\\2002.TTF", 12)
            self.specTab.inner[_class][_spec][counter]['name']:SetTextColor(1, 0.82, 0)
            self.specTab.inner[_class][_spec][counter]['name']:SetShadowColor(0, 0, 0, 0.75)
            self.specTab.inner[_class][_spec][counter]['name']:SetShadowOffset(1, -1)
            self.specTab.inner[_class][_spec][counter]['name']:SetText(spelldata.name)
            self.specTab.inner[_class][_spec][counter]['name']:SetPoint("TOPLEFT", 44, -8)
            
            self.specTab.inner[_class][_spec][counter].bg = self.specTab.inner[_class][_spec][counter]:CreateTexture(nil, "BACKGROUND")
            self.specTab.inner[_class][_spec][counter].bg:SetSize(182, 34)
            self.specTab.inner[_class][_spec][counter].bg:SetTexture("Interface\\Addons\\ClassInfo\\media\\spell_bg")
            self.specTab.inner[_class][_spec][counter].bg:SetTexCoord(0, 182/256, 0, 34/64)
            self.specTab.inner[_class][_spec][counter].bg:SetPoint("LEFT", 38, 0)
            
            self.specTab.inner[_class][_spec][counter].overlays = CreateFrame("Frame", nil, self.specTab.inner[_class][_spec][counter])
            self.specTab.inner[_class][_spec][counter].overlays:SetAllPoints(self.specTab.inner[_class][_spec][counter])  
            self.specTab.inner[_class][_spec][counter].overlays['border'] = self.specTab.inner[_class][_spec][counter].overlays:CreateTexture(nil, "OVERLAY")
            self.specTab.inner[_class][_spec][counter].overlays['border']:SetSize(38, 38)
            self.specTab.inner[_class][_spec][counter].overlays['border']:SetTexture("Interface\\Addons\\ClassInfo\\media\\btn_overlay")
            self.specTab.inner[_class][_spec][counter].overlays['border']:SetTexCoord(13/64, 51/64, 13/64, 51/64)
            self.specTab.inner[_class][_spec][counter].overlays['border']:SetPoint("LEFT")
        
            local subtext = ""
            if spelldata.passive == 1 then
                subtext = "Passive"
            elseif spelldata.rank > 1 then
                subtext = "Rank " .. spelldata.rank
            end
            if subtext ~= "" then
                if self.specTab.inner[_class][_spec][counter]['subtext'] == nil then
                    self.specTab.inner[_class][_spec][counter]['subtext'] = self.specTab.inner[_class][_spec][counter]:CreateFontString(nil, "OVERLAY")
                end
                self.specTab.inner[_class][_spec][counter]['subtext']:SetFont("Fonts\\2002.TTF", 10)
                self.specTab.inner[_class][_spec][counter]['subtext']:SetTextColor(0, 0, 0)
                self.specTab.inner[_class][_spec][counter]['subtext']:SetText(subtext)
                self.specTab.inner[_class][_spec][counter]['subtext']:SetPoint("TOPLEFT", 44, -22)                
            end
    
            if counter % 3 == 1 then
                if counter == 1 then                                                          
                    self.specTab.inner[_class][_spec][counter]:SetPoint("TOPLEFT", 20, -10)                    
                else
                    self.specTab.inner[_class][_spec][counter]:SetPoint("TOPLEFT", 20, -10 -(22 * (counter - 1)))
                end
            elseif counter % 3 == 2 then
                if counter == 2 then
                    self.specTab.inner[_class][_spec][counter]:SetPoint("TOPLEFT", 20 + 220 + 30, -10)
                else
                    self.specTab.inner[_class][_spec][counter]:SetPoint("TOPLEFT", 20 + 220 + 30, -10 -(22 * (counter - 2)))
                end
            else
                if counter == 3 then
                    self.specTab.inner[_class][_spec][counter]:SetPoint("TOPLEFT", 20 + 220 + 30 + 220 + 30, -10)
                else
                    self.specTab.inner[_class][_spec][counter]:SetPoint("TOPLEFT", 20 + 220 + 30 + 220 + 30, -10 -(22 * (counter - 3)))
                end
            end
            -- mouse event tooltip
            self.specTab.inner[_class][_spec][counter]['icon']:SetScript("OnEnter", function(self)                                                
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")                       
                GameTooltip:ClearLines()
                GameTooltip:SetHyperlink(GetSpellLink(spelldata.id))       
            end)
            self.specTab.inner[_class][_spec][counter]['icon']:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
            
            counter = counter + 1
        end 
        if (counter - 1) % 3 == 0 then
            self.specTab.inner[_class][_spec]['height'] = ((counter - 1) / 3) * 62 + 32
            self.specTab.inner[_class][_spec]:SetSize(self.innerWidth, self.specTab.inner[_class][_spec]['height'])
            self.specTab.inner:SetSize(self.innerWidth, self.specTab.inner[_class][_spec]['height'])
        else
            local count = (counter - 1) / 3
            count = math.ceil(count)
            self.specTab.inner[_class][_spec]['height'] = count * 62 + 32
            self.specTab.inner[_class][_spec]:SetSize(self.innerWidth, self.specTab.inner[_class][_spec]['height'])
            self.specTab.inner:SetSize(self.innerWidth, self.specTab.inner[_class][_spec]['height'])
        end
        
        tinsert(self.specFrames, self.specTab.inner[_class][_spec])
    end
end

function ciAddon:SetTalentsTab(_class, _spec)
    local talents = self.spellLib:GetSpecTalents(_class, _spec)
    local covenant_general = self.spellLib:GetGeneralCovenantSpells()
    local covenant_class = self.spellLib:GetClassCovenantSpells(_class)
    local rowCount = 1;
    local rowLevels = {15, 20, 25, 35, 40, 45, 50}
    
    if self.talentsTab[_class] == nil then
        self.talentsTab[_class] = {}        
    end
    if self.talentsTab[_class][_spec] == nil then
        self.talentsTab[_class][_spec] = CreateFrame("Frame", nil, self.talentsTab)
        self.talentsTab[_class][_spec]:SetSize(self.innerWidth, self.innerHeight)
        self.talentsTab[_class][_spec]:SetPoint("TOPLEFT", 0, -10)
        tinsert(self.talentFrames, self.talentsTab[_class][_spec])
        self.talentsTab[_class][_spec].rows = {}
        
        for i=1,21,3 do                    
            self.talentsTab[_class][_spec].rows[rowCount] = CreateFrame("Frame", nil, self.talentsTab[_class][_spec])
            self.talentsTab[_class][_spec].rows[rowCount]:SetSize(self.innerWidth, 65);
            self.talentsTab[_class][_spec].rows[rowCount]:SetPoint("TOPLEFT", 15, -65 * (rowCount - 1));
            
            -- row level
            self.talentsTab[_class][_spec].rows[rowCount].level = self.talentsTab[_class][_spec].rows[rowCount]:CreateFontString(nil, "OVERLAY")
            self.talentsTab[_class][_spec].rows[rowCount].level:SetFont("Fonts\\2002.TTF", 16)
            self.talentsTab[_class][_spec].rows[rowCount].level:SetTextColor(1, 1, 1)
            self.talentsTab[_class][_spec].rows[rowCount].level:SetShadowColor(0, 0, 0, 0.75)
            self.talentsTab[_class][_spec].rows[rowCount].level:SetShadowOffset(1, -1)
            self.talentsTab[_class][_spec].rows[rowCount].level:SetText(rowLevels[rowCount])
            self.talentsTab[_class][_spec].rows[rowCount].level:SetPoint("LEFT")
            
            -- row talents                                              
            for j=1,3 do
                local talent = talents[i + j - 1]
                local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(talent['id'])
                
                self.talentsTab[_class][_spec].rows[rowCount][j] = CreateFrame("Frame", nil, self.talentsTab[_class][_spec].rows[rowCount])
                self.talentsTab[_class][_spec].rows[rowCount][j]:SetSize(240, 65)
                self.talentsTab[_class][_spec].rows[rowCount][j]:SetPoint("TOPLEFT", 51 + (j-1) * 240, 0)
                
                if self.talentsTab[_class][_spec].rows[rowCount][j]['icon'] == nil then
                    self.talentsTab[_class][_spec].rows[rowCount][j]['icon'] = CreateFrame('Button', _class .. "talent" .. "_" .. rowCount .. "-" .. j .. "Icon", self.talentsTab[_class][_spec].rows[rowCount][j], "SecureActionButtonTemplate")
                end        
                self.talentsTab[_class][_spec].rows[rowCount][j]['icon']:SetSize(36, 36)
                self.talentsTab[_class][_spec].rows[rowCount][j]['icon']:SetNormalTexture(icon)
                self.talentsTab[_class][_spec].rows[rowCount][j]['icon']:SetPoint("LEFT")
                                    
                if self.talentsTab[_class][_spec].rows[rowCount][j]['name'] == nil then
                    self.talentsTab[_class][_spec].rows[rowCount][j]['name'] = self.talentsTab[_class][_spec].rows[rowCount][j]:CreateFontString(nil, "OVERLAY")
                end                        
                self.talentsTab[_class][_spec].rows[rowCount][j]['name']:SetFont("Fonts\\2002.TTF", 12)
                self.talentsTab[_class][_spec].rows[rowCount][j]['name']:SetTextColor(1, 0.82, 0)
                self.talentsTab[_class][_spec].rows[rowCount][j]['name']:SetShadowColor(0, 0, 0, 0.75)
                self.talentsTab[_class][_spec].rows[rowCount][j]['name']:SetShadowOffset(1, -1)
                self.talentsTab[_class][_spec].rows[rowCount][j]['name']:SetText(name)
                self.talentsTab[_class][_spec].rows[rowCount][j]['name']:SetPoint("TOPLEFT", 44, -20)
                
                self.talentsTab[_class][_spec].rows[rowCount][j].bg = self.talentsTab[_class][_spec].rows[rowCount][j]:CreateTexture(nil, "BACKGROUND")
                self.talentsTab[_class][_spec].rows[rowCount][j].bg:SetSize(182, 34)
                self.talentsTab[_class][_spec].rows[rowCount][j].bg:SetTexture("Interface\\Addons\\ClassInfo\\media\\spell_bg")
                self.talentsTab[_class][_spec].rows[rowCount][j].bg:SetTexCoord(0, 182/256, 0, 34/64)
                self.talentsTab[_class][_spec].rows[rowCount][j].bg:SetPoint("LEFT", 38, 0)
                
                self.talentsTab[_class][_spec].rows[rowCount][j].overlays = CreateFrame("Frame", nil, self.talentsTab[_class][_spec].rows[rowCount][j])
                self.talentsTab[_class][_spec].rows[rowCount][j].overlays:SetAllPoints(self.talentsTab[_class][_spec].rows[rowCount][j])  
                self.talentsTab[_class][_spec].rows[rowCount][j].overlays['border'] = self.talentsTab[_class][_spec].rows[rowCount][j].overlays:CreateTexture(nil, "OVERLAY")
                self.talentsTab[_class][_spec].rows[rowCount][j].overlays['border']:SetSize(38, 38)
                self.talentsTab[_class][_spec].rows[rowCount][j].overlays['border']:SetTexture("Interface\\Addons\\ClassInfo\\media\\btn_overlay")
                self.talentsTab[_class][_spec].rows[rowCount][j].overlays['border']:SetTexCoord(13/64, 51/64, 13/64, 51/64)
                self.talentsTab[_class][_spec].rows[rowCount][j].overlays['border']:SetPoint("LEFT")              
                
            
                -- mouse event tooltip
                self.talentsTab[_class][_spec].rows[rowCount][j]['icon']:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")                        
                    GameTooltip:ClearLines()
                    GameTooltip:SetHyperlink(GetSpellLink(talent['id']))       
                end)
                self.talentsTab[_class][_spec].rows[rowCount][j]['icon']:SetScript("OnLeave", function(self)
                    GameTooltip:Hide()
                end)
            end
            rowCount = rowCount + 1                        
        end
        
        if self.talentsTab[_class][_spec]['covenants'] == nil then
            self.talentsTab[_class][_spec]['covenants'] = CreateFrame("Frame", nil, self.talentsTab[_class][_spec])
        end
        self.talentsTab[_class][_spec]['covenants']:SetSize(740, 100)
        self.talentsTab[_class][_spec]['covenants']:SetPoint("BOTTOMLEFT", 15, 10, self.talentsTab[_class][_spec])
        
        -- covenant abilites
        local covenants = {'Kyrian', 'Necrolord', 'Night fae', 'Venthyr'}
        for i,covName in pairs(covenants) do
            self.talentsTab[_class][_spec]['covenants'][covName] = CreateFrame("Frame", nil, self.talentsTab[_class][_spec]['covenants'])
            self.talentsTab[_class][_spec]['covenants'][covName]:SetSize(185, 100)
            self.talentsTab[_class][_spec]['covenants'][covName]:SetPoint("LEFT", (i - 1) * 185, 0)
            self.talentsTab[_class][_spec]['covenants'][covName]['name'] = self.talentsTab[_class][_spec]['covenants'][covName]:CreateFontString(nil, "OVERLAY")
            self.talentsTab[_class][_spec]['covenants'][covName]['name']:SetFont("Fonts\\2002.TTF", 16)
            self.talentsTab[_class][_spec]['covenants'][covName]['name']:SetTextColor(1, 1, 1)
            self.talentsTab[_class][_spec]['covenants'][covName]['name']:SetShadowColor(0, 0, 0, 0.75)
            self.talentsTab[_class][_spec]['covenants'][covName]['name']:SetShadowOffset(1, -1)
            self.talentsTab[_class][_spec]['covenants'][covName]['name']:SetText(covName)
            self.talentsTab[_class][_spec]['covenants'][covName]['name']:SetPoint("TOP", 0, 0, self.talentsTab[_class][_spec]['covenants'][covName]) 
            
            local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(covenant_general[i]['id'])
            self.talentsTab[_class][_spec]['covenants'][covName]['class'] = CreateFrame("Frame", nil, self.talentsTab[_class][_spec]['covenants'][covName])
            self.talentsTab[_class][_spec]['covenants'][covName]['class']:SetSize(93, 100)
            self.talentsTab[_class][_spec]['covenants'][covName]['class']:SetPoint("TOPLEFT", 0, 0)             
            self.talentsTab[_class][_spec]['covenants'][covName]['class']['icon'] = CreateFrame('Button', _class .. covName .. "Icon", self.talentsTab[_class][_spec]['covenants'][covName]['class'], "SecureActionButtonTemplate")      
            self.talentsTab[_class][_spec]['covenants'][covName]['class']['icon']:SetSize(36, 36)
            self.talentsTab[_class][_spec]['covenants'][covName]['class']['icon']:SetNormalTexture(icon)
            self.talentsTab[_class][_spec]['covenants'][covName]['class']['icon']:SetPoint("CENTER", 15, 0)
            self.talentsTab[_class][_spec]['covenants'][covName]['class'].overlays = CreateFrame("Frame", nil, self.talentsTab[_class][_spec]['covenants'][covName]['class'])
            self.talentsTab[_class][_spec]['covenants'][covName]['class'].overlays:SetAllPoints(self.talentsTab[_class][_spec]['covenants'][covName]['class'])  
            self.talentsTab[_class][_spec]['covenants'][covName]['class'].overlays['border'] = self.talentsTab[_class][_spec]['covenants'][covName]['class'].overlays:CreateTexture(nil, "OVERLAY")
            self.talentsTab[_class][_spec]['covenants'][covName]['class'].overlays['border']:SetSize(38, 38)
            self.talentsTab[_class][_spec]['covenants'][covName]['class'].overlays['border']:SetTexture("Interface\\Addons\\ClassInfo\\media\\btn_overlay")
            self.talentsTab[_class][_spec]['covenants'][covName]['class'].overlays['border']:SetTexCoord(13/64, 51/64, 13/64, 51/64)
            self.talentsTab[_class][_spec]['covenants'][covName]['class'].overlays['border']:SetPoint("CENTER", 15, 0)
            -- mouse event tooltip
            self.talentsTab[_class][_spec]['covenants'][covName]['class']['icon']:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")                        
                GameTooltip:ClearLines()
                GameTooltip:SetHyperlink(GetSpellLink(covenant_general[i]['id']))       
            end)
            self.talentsTab[_class][_spec]['covenants'][covName]['class']['icon']:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end) 
            
            local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(covenant_class[i]['id'])
            self.talentsTab[_class][_spec]['covenants'][covName]['spec'] = CreateFrame("Frame", nil, self.talentsTab[_class][_spec]['covenants'][covName])
            self.talentsTab[_class][_spec]['covenants'][covName]['spec']:SetSize(92, 100)
            self.talentsTab[_class][_spec]['covenants'][covName]['spec']:SetPoint("TOPLEFT", 93, 0)            
            self.talentsTab[_class][_spec]['covenants'][covName]['spec']['icon'] = CreateFrame('Button', _spec .. covName .. "Icon", self.talentsTab[_class][_spec]['covenants'][covName]['spec'], "SecureActionButtonTemplate")      
            self.talentsTab[_class][_spec]['covenants'][covName]['spec']['icon']:SetSize(36, 36)
            self.talentsTab[_class][_spec]['covenants'][covName]['spec']['icon']:SetNormalTexture(icon)
            self.talentsTab[_class][_spec]['covenants'][covName]['spec']['icon']:SetPoint("CENTER", -15, 0)
            self.talentsTab[_class][_spec]['covenants'][covName]['spec'].overlays = CreateFrame("Frame", nil, self.talentsTab[_class][_spec]['covenants'][covName]['spec'])
            self.talentsTab[_class][_spec]['covenants'][covName]['spec'].overlays:SetAllPoints(self.talentsTab[_class][_spec]['covenants'][covName]['spec'])  
            self.talentsTab[_class][_spec]['covenants'][covName]['spec'].overlays['border'] = self.talentsTab[_class][_spec]['covenants'][covName]['spec'].overlays:CreateTexture(nil, "OVERLAY")
            self.talentsTab[_class][_spec]['covenants'][covName]['spec'].overlays['border']:SetSize(38, 38)
            self.talentsTab[_class][_spec]['covenants'][covName]['spec'].overlays['border']:SetTexture("Interface\\Addons\\ClassInfo\\media\\btn_overlay")
            self.talentsTab[_class][_spec]['covenants'][covName]['spec'].overlays['border']:SetTexCoord(13/64, 51/64, 13/64, 51/64)
            self.talentsTab[_class][_spec]['covenants'][covName]['spec'].overlays['border']:SetPoint("CENTER", -15, 0)
            -- mouse event tooltip
            self.talentsTab[_class][_spec]['covenants'][covName]['spec']['icon']:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")                        
                GameTooltip:ClearLines()
                GameTooltip:SetHyperlink(GetSpellLink(covenant_class[i]['id']))       
            end)
            self.talentsTab[_class][_spec]['covenants'][covName]['spec']['icon']:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
        end                  
    end
end

-- Shows the talents for the selected class and spec
function ciAddon:SetPvpTalentsTab(_class, _spec)
    local pvp_talents = self.spellLib:GetSpecPVPTalents(_class, _spec)
    local rowCount = 1;
    
    local counter = 1
    local offsetTop = -10
    
    if self.pvpTab[_class] == nil then
        self.pvpTab[_class] = {}             
    end
    if self.pvpTab[_class][_spec] == nil then
        self.pvpTab[_class][_spec] = CreateFrame("Frame", _class .. "basicSpells", self.pvpTab)
        self.pvpTab[_class][_spec]:SetPoint("TOPLEFT", 0, offsetTop, self.pvpTab) 
               
        for i, spelldata in pairs(pvp_talents) do            
            local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(spelldata.id)                
            if self.pvpTab[_class][_spec][counter] == nil then
                self.pvpTab[_class][_spec][counter] = CreateFrame("Frame", _class .. "basicSpells" .. counter, self.pvpTab[_class][_spec])
                self.pvpTab[_class][_spec][counter]:SetSize(220, 40)                                
            end
            if self.pvpTab[_class][_spec][counter]['icon'] == nil then
                self.pvpTab[_class][_spec][counter]['icon'] = CreateFrame('Button', _class .. "basicSpells" .. counter .. "Icon", self.pvpTab[_class][_spec][counter], "SecureActionButtonTemplate")
            end        
            self.pvpTab[_class][_spec][counter]['icon']:SetSize(36, 36)
            self.pvpTab[_class][_spec][counter]['icon']:SetNormalTexture(icon)
            self.pvpTab[_class][_spec][counter]['icon']:SetPoint("LEFT")
                                
            if self.pvpTab[_class][_spec][counter]['name'] == nil then
                self.pvpTab[_class][_spec][counter]['name'] = self.pvpTab[_class][_spec][counter]:CreateFontString(nil, "OVERLAY")
            end                        
            self.pvpTab[_class][_spec][counter]['name']:SetFont("Fonts\\2002.TTF", 12)
            self.pvpTab[_class][_spec][counter]['name']:SetTextColor(1, 0.82, 0)
            self.pvpTab[_class][_spec][counter]['name']:SetShadowColor(0, 0, 0, 0.75)
            self.pvpTab[_class][_spec][counter]['name']:SetShadowOffset(1, -1)
            self.pvpTab[_class][_spec][counter]['name']:SetText(spelldata.name)
            self.pvpTab[_class][_spec][counter]['name']:SetPoint("TOPLEFT", 44, -8)
            
            self.pvpTab[_class][_spec][counter].bg = self.pvpTab[_class][_spec][counter]:CreateTexture(nil, "BACKGROUND")
            self.pvpTab[_class][_spec][counter].bg:SetSize(182, 34)
            self.pvpTab[_class][_spec][counter].bg:SetTexture("Interface\\Addons\\ClassInfo\\media\\spell_bg")
            self.pvpTab[_class][_spec][counter].bg:SetTexCoord(0, 182/256, 0, 34/64)
            self.pvpTab[_class][_spec][counter].bg:SetPoint("LEFT", 38, 0)
            
            self.pvpTab[_class][_spec][counter].overlays = CreateFrame("Frame", nil, self.pvpTab[_class][_spec][counter])
            self.pvpTab[_class][_spec][counter].overlays:SetAllPoints(self.pvpTab[_class][_spec][counter])  
            self.pvpTab[_class][_spec][counter].overlays['border'] = self.pvpTab[_class][_spec][counter].overlays:CreateTexture(nil, "OVERLAY")
            self.pvpTab[_class][_spec][counter].overlays['border']:SetSize(38, 38)
            self.pvpTab[_class][_spec][counter].overlays['border']:SetTexture("Interface\\Addons\\ClassInfo\\media\\btn_overlay")
            self.pvpTab[_class][_spec][counter].overlays['border']:SetTexCoord(13/64, 51/64, 13/64, 51/64)
            self.pvpTab[_class][_spec][counter].overlays['border']:SetPoint("LEFT")
    
            if counter % 3 == 1 then
                if counter == 1 then                                                          
                    self.pvpTab[_class][_spec][counter]:SetPoint("TOPLEFT", 20, -10)                    
                else
                    self.pvpTab[_class][_spec][counter]:SetPoint("TOPLEFT", 20, -10 -(22 * (counter - 1)))
                end
            elseif counter % 3 == 2 then
                if counter == 2 then
                    self.pvpTab[_class][_spec][counter]:SetPoint("TOPLEFT", 20 + 220 + 30, -10)
                else
                    self.pvpTab[_class][_spec][counter]:SetPoint("TOPLEFT", 20 + 220 + 30, -10 -(22 * (counter - 2)))
                end
            else
                if counter == 3 then
                    self.pvpTab[_class][_spec][counter]:SetPoint("TOPLEFT", 20 + 220 + 30 + 220 + 30, -10)
                else
                    self.pvpTab[_class][_spec][counter]:SetPoint("TOPLEFT", 20 + 220 + 30 + 220 + 30, -10 -(22 * (counter - 3)))
                end
            end
            -- mouse event tooltip
            self.pvpTab[_class][_spec][counter]['icon']:SetScript("OnEnter", function(self)                                                
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")                       
                GameTooltip:ClearLines()
                GameTooltip:SetHyperlink(GetSpellLink(spelldata.id))       
            end)
            self.pvpTab[_class][_spec][counter]['icon']:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
            
            counter = counter + 1
        end 
        if (counter - 1) % 3 == 0 then
            self.pvpTab[_class][_spec]['height'] = ((counter - 1) / 3) * 62 + 32
            self.pvpTab[_class][_spec]:SetSize(self.innerWidth, self.specTab.inner[_class][_spec]['height'])
        else
            local count = (counter - 1) / 3
            count = math.ceil(count)
            self.pvpTab[_class][_spec]['height'] = count * 62 + 32
            self.pvpTab[_class][_spec]:SetSize(self.innerWidth, self.specTab.inner[_class][_spec]['height'])
        end
               
        tinsert(self.pvpFrames, self.pvpTab[_class][_spec])
    end    
end

-- display the talentsTab
function ciAddon:ShowTalentsTab()
    for i,talentFrame in pairs (self.talentFrames) do
        talentFrame:Hide()        
    end
    self.talentsTab[self.currentClass][self.currentSpec]:Show()
    self.talentsTab:Show()
end

-- displays the classTab
function ciAddon:ShowClassTab()
    for i,classFrame in pairs (self.classFrames) do
        classFrame:Hide()        
    end
    self.classTab.inner:SetSize(self.innerWidth, self.classTab.inner[self.currentClass]['height'])        
    self.classTab.inner[self.currentClass]:Show()
    self.classTab:Show()
end

function ciAddon:ShowSpecTab()
    for i,specFrame in pairs (self.specFrames) do
        specFrame:Hide()        
    end    
    self.specTab.inner:SetSize(self.innerWidth,self.specTab.inner[self.currentClass][self.currentSpec]['height'])    
    self.specTab.inner[self.currentClass][self.currentSpec]:Show()
    self.specTab:Show()
end

-- displays the pvpTab
function ciAddon:ShowPvpTab()
    for i,pvpFrame in pairs (self.pvpFrames) do
        pvpFrame:Hide()        
    end
    self.pvpTab[self.currentClass][self.currentSpec]:Show()
    self.pvpTab:Show()
end

-- hide tabItems
function ciAddon:HideTabbing()
    
end

-- highlights the selected tabItem
-- @param string name name of the item
function ciAddon:SetTabbing(name) 
    local tabItems = { "selection", "class", "spec", "talents", "pvp" }
    for i,tab in pairs(tabItems) do
        if tab == name then
            self.tabbings[tab]:SetNormalTexture("Interface\\Addons\\ClassInfo\\media\\tabbing_bg_selected")
            self.tabbings[tab].text:SetTextColor(1, 1, 0)
        else
            self.tabbings[tab]:SetNormalTexture("Interface\\Addons\\ClassInfo\\media\\tabbing_bg")
            self.tabbings[tab].text:SetTextColor(0.5, 0.5, 0.5)
        end
    end        
end

-- Splits a String into a table
-- s => the input string
-- delimiter => char as delimiter
function ciAddon:SplitString(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end
