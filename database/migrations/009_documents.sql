-- =====================================================
-- Bolt Workspace
-- Migration: 009_activity_logs.sql
-- Description: Activity Logs / Audit Trail
-- =====================================================

CREATE TABLE public.activity_logs (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    profile_id UUID,

    module TEXT NOT NULL,

    action TEXT NOT NULL,

    entity_type TEXT NOT NULL,

    entity_id UUID,

    description TEXT,

    ip_address TEXT,

    user_agent TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_activity_profile
        FOREIGN KEY (profile_id)
        REFERENCES public.profiles(id)
        ON DELETE SET NULL
);

-- =====================================================
-- Indexes
-- =====================================================

CREATE INDEX idx_activity_profile
ON public.activity_logs(profile_id);

CREATE INDEX idx_activity_module
ON public.activity_logs(module);

CREATE INDEX idx_activity_action
ON public.activity_logs(action);

CREATE INDEX idx_activity_created
ON public.activity_logs(created_at);

-- =====================================================
-- Enable Row Level Security
-- =====================================================

ALTER TABLE public.activity_logs
ENABLE ROW LEVEL SECURITY;