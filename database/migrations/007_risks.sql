-- =====================================================
-- Bolt Workspace
-- Migration: 007_risks.sql
-- Description: Project Risk Register
-- =====================================================

CREATE TABLE public.risks (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    risk_code TEXT NOT NULL UNIQUE,

    project_id UUID NOT NULL,

    milestone_id UUID,

    title TEXT NOT NULL,

    description TEXT,

    category TEXT NOT NULL DEFAULT 'Technical'
        CHECK (
            category IN (
                'Technical',
                'Financial',
                'Operational',
                'Security',
                'Compliance',
                'Vendor',
                'Resource',
                'Schedule',
                'Legal',
                'Other'
            )
        ),

    probability TEXT NOT NULL DEFAULT 'Medium'
        CHECK (
            probability IN ('Low','Medium','High')
        ),

    impact TEXT NOT NULL DEFAULT 'Medium'
        CHECK (
            impact IN ('Low','Medium','High','Critical')
        ),

    priority TEXT NOT NULL DEFAULT 'Medium'
        CHECK (
            priority IN ('Low','Medium','High','Critical')
        ),

    risk_score INTEGER
        CHECK (
            risk_score IS NULL
            OR risk_score BETWEEN 1 AND 12
        ),

    status TEXT NOT NULL DEFAULT 'Open'
        CHECK (
            status IN (
                'Open',
                'Monitoring',
                'Mitigated',
                'Closed',
                'Converted to Issue'
            )
        ),

    mitigation_plan TEXT,

    contingency_plan TEXT,

    owner_id UUID NOT NULL,

    identified_by UUID NOT NULL,

    identified_date DATE NOT NULL DEFAULT CURRENT_DATE,

    target_resolution_date DATE,

    closed_date DATE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_risk_project
        FOREIGN KEY (project_id)
        REFERENCES public.projects(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_risk_milestone
        FOREIGN KEY (milestone_id)
        REFERENCES public.milestones(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_risk_owner
        FOREIGN KEY (owner_id)
        REFERENCES public.profiles(id),

    CONSTRAINT fk_risk_identified_by
        FOREIGN KEY (identified_by)
        REFERENCES public.profiles(id)
);

-- =====================================================
-- Indexes
-- =====================================================

CREATE INDEX idx_risks_project
ON public.risks(project_id);

CREATE INDEX idx_risks_milestone
ON public.risks(milestone_id);

CREATE INDEX idx_risks_status
ON public.risks(status);

CREATE INDEX idx_risks_priority
ON public.risks(priority);

CREATE INDEX idx_risks_category
ON public.risks(category);

CREATE INDEX idx_risks_owner
ON public.risks(owner_id);

-- =====================================================
-- Trigger
-- =====================================================

CREATE TRIGGER trg_risks_updated_at
BEFORE UPDATE
ON public.risks
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

-- =====================================================
-- Enable Row Level Security
-- =====================================================

ALTER TABLE public.risks
ENABLE ROW LEVEL SECURITY;