-- =====================================================
-- Bolt Workspace
-- Migration: 005_milestones.sql
-- Description: Project Milestones
-- =====================================================

CREATE TABLE public.milestones (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    project_id UUID NOT NULL,

    milestone_name TEXT NOT NULL,

    description TEXT,

    sequence_no INTEGER NOT NULL,

    status TEXT NOT NULL DEFAULT 'Not Started'
        CHECK (status IN ('Not Started','In Progress','Completed','Delayed')),

    progress_percentage INTEGER NOT NULL DEFAULT 0
        CHECK (progress_percentage BETWEEN 0 AND 100),

    planned_start_date DATE,

    planned_end_date DATE,

    actual_start_date DATE,

    actual_end_date DATE,

    created_by UUID NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_milestone_project
        FOREIGN KEY (project_id)
        REFERENCES public.projects(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_milestone_created_by
        FOREIGN KEY (created_by)
        REFERENCES public.profiles(id)
);

-- =====================================================
-- Prevent duplicate milestone sequence numbers
-- within the same project
-- =====================================================

ALTER TABLE public.milestones
ADD CONSTRAINT uq_project_sequence
UNIQUE (project_id, sequence_no);

-- =====================================================
-- Indexes
-- =====================================================

CREATE INDEX idx_milestones_project
ON public.milestones(project_id);

CREATE INDEX idx_milestones_status
ON public.milestones(status);

CREATE INDEX idx_milestones_sequence
ON public.milestones(sequence_no);

-- =====================================================
-- Updated At Trigger
-- =====================================================

CREATE TRIGGER trg_milestones_updated_at
BEFORE UPDATE
ON public.milestones
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

-- =====================================================
-- Enable Row Level Security
-- =====================================================

ALTER TABLE public.milestones
ENABLE ROW LEVEL SECURITY;