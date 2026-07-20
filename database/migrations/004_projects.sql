-- =====================================================
-- Bolt Workspace
-- Migration: 004_projects.sql
-- Description: Projects and Project Members
-- =====================================================

-- =====================================================
-- Projects Table
-- =====================================================

CREATE TABLE public.projects (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    project_code TEXT NOT NULL UNIQUE,

    project_name TEXT NOT NULL,

    description TEXT,

    project_type TEXT NOT NULL DEFAULT 'Internal'
        CHECK (project_type IN ('Internal','Client','R&D','Compliance')),

    status TEXT NOT NULL DEFAULT 'Planning'
        CHECK (status IN ('Planning','Active','On Hold','Completed','Cancelled')),

    priority TEXT NOT NULL DEFAULT 'Medium'
        CHECK (priority IN ('Low','Medium','High','Critical')),

    progress_percentage INTEGER NOT NULL DEFAULT 0
        CHECK (progress_percentage BETWEEN 0 AND 100),

    start_date DATE,

    target_end_date DATE,

    actual_end_date DATE,

    project_owner_id UUID NOT NULL,

    created_by UUID NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_project_owner
        FOREIGN KEY(project_owner_id)
        REFERENCES public.profiles(id),

    CONSTRAINT fk_project_created_by
        FOREIGN KEY(created_by)
        REFERENCES public.profiles(id)
);

-- =====================================================
-- Project Members
-- =====================================================

CREATE TABLE public.project_members (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    project_id UUID NOT NULL,

    profile_id UUID NOT NULL,

    member_role TEXT NOT NULL DEFAULT 'Member'
        CHECK (member_role IN ('Owner','Member','Viewer')),

    joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_pm_project
        FOREIGN KEY(project_id)
        REFERENCES public.projects(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_pm_profile
        FOREIGN KEY(profile_id)
        REFERENCES public.profiles(id)
        ON DELETE CASCADE
);

-- =====================================================
-- Indexes
-- =====================================================

CREATE INDEX idx_projects_status
ON public.projects(status);

CREATE INDEX idx_projects_priority
ON public.projects(priority);

CREATE INDEX idx_projects_owner
ON public.projects(project_owner_id);

CREATE INDEX idx_project_members_project
ON public.project_members(project_id);

CREATE INDEX idx_project_members_profile
ON public.project_members(profile_id);

-- =====================================================
-- Trigger
-- =====================================================

CREATE TRIGGER trg_projects_updated_at
BEFORE UPDATE ON public.projects
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

-- =====================================================
-- Enable Row Level Security
-- =====================================================

ALTER TABLE public.projects
ENABLE ROW LEVEL SECURITY;

ALTER TABLE public.project_members
ENABLE ROW LEVEL SECURITY;