-- =====================================================
-- Bolt Workspace
-- Migration: 008_issues.sql
-- Description: Project Issue Register
-- =====================================================

CREATE TABLE public.issues (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    issue_code TEXT NOT NULL UNIQUE,

    project_id UUID NOT NULL,

    milestone_id UUID,

    related_risk_id UUID,

    title TEXT NOT NULL,

    description TEXT,

    severity TEXT NOT NULL DEFAULT 'Medium'
        CHECK (
            severity IN ('Low','Medium','High','Critical')
        ),

    priority TEXT NOT NULL DEFAULT 'Medium'
        CHECK (
            priority IN ('Low','Medium','High','Critical')
        ),

    status TEXT NOT NULL DEFAULT 'Open'
        CHECK (
            status IN (
                'Open',
                'In Progress',
                'Resolved',
                'Closed'
            )
        ),

    root_cause TEXT,

    resolution TEXT,

    owner_id UUID NOT NULL,

    reported_by UUID NOT NULL,

    reported_date DATE NOT NULL DEFAULT CURRENT_DATE,

    target_resolution_date DATE,

    resolved_date DATE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_issue_project
        FOREIGN KEY (project_id)
        REFERENCES public.projects(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_issue_milestone
        FOREIGN KEY (milestone_id)
        REFERENCES public.milestones(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_issue_risk
        FOREIGN KEY (related_risk_id)
        REFERENCES public.risks(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_issue_owner
        FOREIGN KEY (owner_id)
        REFERENCES public.profiles(id),

    CONSTRAINT fk_issue_reported_by
        FOREIGN KEY (reported_by)
        REFERENCES public.profiles(id)
);

-- =====================================================
-- Indexes
-- =====================================================

CREATE INDEX idx_issues_project
ON public.issues(project_id);

CREATE INDEX idx_issues_milestone
ON public.issues(milestone_id);

CREATE INDEX idx_issues_risk
ON public.issues(related_risk_id);

CREATE INDEX idx_issues_status
ON public.issues(status);

CREATE INDEX idx_issues_priority
ON public.issues(priority);

CREATE INDEX idx_issues_owner
ON public.issues(owner_id);

-- =====================================================
-- Trigger
-- =====================================================

CREATE TRIGGER trg_issues_updated_at
BEFORE UPDATE
ON public.issues
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

-- =====================================================
-- Enable Row Level Security
-- =====================================================

ALTER TABLE public.issues
ENABLE ROW LEVEL SECURITY;