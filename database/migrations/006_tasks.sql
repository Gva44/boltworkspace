-- =====================================================
-- Bolt Workspace
-- Migration: 006_tasks.sql
-- Description: Project Tasks
-- =====================================================

CREATE TABLE public.tasks (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    task_code TEXT NOT NULL UNIQUE,

    project_id UUID NOT NULL,

    milestone_id UUID NOT NULL,

    task_name TEXT NOT NULL,

    description TEXT,

    assigned_to UUID,

    created_by UUID NOT NULL,

    priority TEXT NOT NULL DEFAULT 'Medium'
        CHECK (priority IN ('Low','Medium','High','Critical')),

    status TEXT NOT NULL DEFAULT 'To Do'
        CHECK (status IN ('To Do','In Progress','Review','Completed','Blocked')),

    progress_percentage INTEGER NOT NULL DEFAULT 0
        CHECK (progress_percentage BETWEEN 0 AND 100),

    estimated_hours NUMERIC(6,2),

    actual_hours NUMERIC(6,2),

    planned_start_date DATE,

    due_date DATE,

    completed_date DATE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_task_project
        FOREIGN KEY (project_id)
        REFERENCES public.projects(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_task_milestone
        FOREIGN KEY (milestone_id)
        REFERENCES public.milestones(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_task_assigned_to
        FOREIGN KEY (assigned_to)
        REFERENCES public.profiles(id),

    CONSTRAINT fk_task_created_by
        FOREIGN KEY (created_by)
        REFERENCES public.profiles(id)
);

-- =====================================================
-- Indexes
-- =====================================================

CREATE INDEX idx_tasks_project
ON public.tasks(project_id);

CREATE INDEX idx_tasks_milestone
ON public.tasks(milestone_id);

CREATE INDEX idx_tasks_assigned_to
ON public.tasks(assigned_to);

CREATE INDEX idx_tasks_status
ON public.tasks(status);

CREATE INDEX idx_tasks_priority
ON public.tasks(priority);

-- =====================================================
-- Trigger
-- =====================================================

CREATE TRIGGER trg_tasks_updated_at
BEFORE UPDATE
ON public.tasks
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

-- =====================================================
-- Enable Row Level Security
-- =====================================================

ALTER TABLE public.tasks
ENABLE ROW LEVEL SECURITY;